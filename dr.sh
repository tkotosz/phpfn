#!/bin/sh
echo "Build and deploy..."
fn delete function phpapp phpfn
fn --verbose deploy --app phpapp --local --no-bump
echo "Run..."
fn invoke phpapp phpfn
echo "Run with input..."
echo -n '{"name": "Tibor"}' | fn invoke phpapp phpfn
