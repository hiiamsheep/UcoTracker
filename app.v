module main

import veb
import os
import json

pub struct MarkerData {
    content []string
    info    string
}

pub struct Context {
    veb.Context
}

pub struct App {
    mut:
    data map[string]MarkerData
}

fn load_data(file string) !map[string]MarkerData {
    content := os.read_file(file) or {
        return error('Failed to read $file')
    }
    parsed := json.decode(map[string]MarkerData, content) or {
        return error('Failed to decode JSON: $err')
    }
    return parsed
}

fn save_data(data map[string]MarkerData, file string) ! {
    json_str := json.encode_pretty(data)
    os.write_file(file, json_str) or {
        return error('Failed to write to $file')
    }
}

@['/']
pub fn (mut app App) index(mut ctx Context) veb.Result {
    content := os.read_file('static/index.html') or {
        return ctx.text('Error loading index.html')
    }
    return ctx.html(content)
}

@['/aruco.js']
pub fn (mut app App) aruco_js(mut ctx Context) veb.Result {
    content := os.read_file('static/aruco.js') or {
        return ctx.text('Error loading aruco.js')
    }
    ctx.set_content_type('application/javascript')
    return ctx.text(content)
}

@['/cv.js']
pub fn (mut app App) cv_js(mut ctx Context) veb.Result {
    content := os.read_file('static/cv.js') or {
        return ctx.text('Error loading cv.js')
    }
    ctx.set_content_type('application/javascript')
    return ctx.text(content)
}

@['/marker_content/:id'; get]
pub fn (mut app App) marker_content(mut ctx Context, id string) veb.Result {
    marker_data := app.data[id] or {
        return ctx.text(json.encode({
            'error': 'No data for marker id: $id'
        }))
    }
    ctx.set_content_type('application/json')
    return ctx.text(json.encode(marker_data))
}

@['/marker_content/:id'; post]
pub fn (mut app App) update_marker_content(mut ctx Context, id string) veb.Result {

    body := ctx.req.data
    if body.len == 0 {
        return ctx.text('Missing body data')
    }

    parsed := json.decode(MarkerData, body) or {
        return ctx.text('Failed to decode JSON: $err')
    }

    app.data[id] = parsed

    save_data(app.data, 'static/data.json') or {
        return ctx.text('Failed to save data')
    }

    ctx.set_content_type('application/json')
    return ctx.text(json.encode(parsed))
}

fn main() {
    data := load_data('static/data.json') or {
        eprintln('Failed to load data.json: $err')
        return
    }

    mut app := App{
        data: data
    }

    veb.run[App, Context](mut app, 8000)
}

// made with <3 and a bit of chaos :3