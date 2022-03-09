import Foundation
let ball = OvalShape(width: 40, height: 40)

// new variable to store the array

var barriers: [Shape] = []

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

// Code to setup the Ball

fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)
    scene.add(ball)
    ball.hasPhysics = true
    ball.fillColor = .orange
}

fileprivate func setupBarrier() {
    // Add a barrier to the scene.
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    scene.add(barrier)
    barrier.isImmobile = true
}

fileprivate func setupFunnel() {
    // Add a funnel to the scene.
    funnel.position = Point(x: 200, y:
    scene.height - 25)
    scene.add(funnel)
    
    funnel.onTapped = dropBall
    funnel.fillColor = .purple
}

func setup() {
    setupBall()
    ball.onCollision = ballCollided(with:)

// Make a bouncier ball ( the value can range from 0 to 1) - pg 246
    ball.bounciness = 0.7
    
// reset the game - pg 245
    
    ball.onTapped = resetGame
    
// prevent the ball from dragging pg 242
    
    ball.isDraggable = false
    
// This lets the scene know to keep track of the ball's location - pg 243
    
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    
// callback of the scene to print a new position everytime the shape is moved - pg 247
    
    scene.onShapeMoved = printPosition(of:)
    
//  Add a call to reset game pg 245
    
    resetGame()
    
    setupBarrier()
    
// Tilt the Barrier - pg 246
    barrier.angle = 0.1
    
    setupFunnel()
    ball.isDraggable = false
    
// Add a target to the scene - page 238.
    
    setupTarget()
    target.name = "target"
    ball.isDraggable = false
}

func dropBall() {
    ball.position = funnel.position

    // Stop the runaway Ball pg 242
    ball.stopAllMotion()
    
    // unlock and lock the barrier - pg 244
    barrier.isDraggable = false
}


let barrierWidth = 300.0
let barrierHeight = 25.0

let barrierPoints = [
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y:
       barrierHeight),
    Point(x: barrierWidth, y: 0)
]

let barrier = PolygonShape(points:
   barrierPoints)

let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]

let funnel = PolygonShape(points:
    funnelPoints)

// Add a Target Shape

let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]

let target = PolygonShape(points:
    targetPoints)

// A function to for Target Shape

func setupTarget() {
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .red

    scene.add(target)
}

// Handles collisions between the ball and the targets - page 240.

func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" { return }
    
    otherShape.fillColor = .green
}

// function to lock the barrier - pg 243

func ballExitedScene() {

// unlock and lock the barrier - same in dropBall() pg 244
    
    barrier.isDraggable = true
}

// Resets the game by moving the ball below
// the scene,which will unlock the barriers. pg 245

func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

// A helper function to print a shape's position to the console - pg 247

func printPosition(of shape: Shape) {
    print(shape.position)
}
