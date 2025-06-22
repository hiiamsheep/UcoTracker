module main

import veb
import os


pub struct Context {
    veb.Context
}

// app data
pub struct App {}

@['/']
pub fn (app &App) index(mut ctx Context) veb.Result {
    content := os.read_file('static/index.html') or {
        return ctx.text('Error: cannot load HTML file.')
    }
    return ctx.html(content)
}

@['/test']
pub fn (app &App) test(mut ctx Context) veb.Result {
    return ctx.html('<h1>Hello from /test</h1>')
}

fn main() {
    mut app := &App{}
    veb.run[App, Context](mut app, 8000)
}
