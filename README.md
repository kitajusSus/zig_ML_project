# ZIG MACHINE LEARNIN LIB PROJECT "Ballin":
 While I am trying to learn zig I plan to use this knowlegde to make basics of the zigs liblary to use it in matrix multiplications and machine learning later while progress goes. 
 This is a basic outline of the development plan for Ballin:

## Current State: 
**The library currently has a basic structure and a few functions implemented.**

## Short-Term Goals:
* Implement more machine learning algorithms (e.g. decision trees, clustering)
* Add support for more data types (e.g. images, text)
* Improve the documentation and examples
## Mid-Term Goals:
* Implement a more robust and efficient data structure for the dataset
* Add support for parallel processing and GPU acceleration
* Implement a simple neural network
## Long-Term Goals:
* Implement a more advanced neural network architecture (e.g. convolutional neural networks, recurrent neural networks)
* Add support for more advanced machine learning techniques (e.g. transfer learning, attention mechanisms)
* Improve the performance and scalability of the library
## What I've Implemented So Far
Update 0.1:
* creating tensors and maricies
### Tensor
Tensor is a structut=re which represents multi dimentional array of numbers. 
#### Functions
`init(data: []f64, shape: []usize` : creates new tensor with given data and shape
`mul(other: Tensor)` : multiplies two tensors
#### Example 
```zig
var tensor1 = Tensor.init([_]f64{ 1, 2, 3 }, [_]usize{ 3 });
var tensor2 = Tensor.init([_]f64{ 4, 5, 6 }, [_]usize{ 3 });
var result = tensor1.mul(tensor2);
```
### Matrix
just matrix you know what is this 
#### Functions
`init(data: []f64, rows: usize, cols: usize)` creates new matrix with given data and dimentions
`mul(other: Matrix)` multiplies two marix's (english is not my first language idk how to write this)
#### Example program
```zig
const std = @import("std");
const ballin = @import("ballin.zig");

pub fn main() !void {
    // creating two matrices
    var matrix1 = ballin.Matrix.init([_]f64{ 1, 2, 3, 4 }, 2, 2);
    var matrix2 = ballin.Matrix.init([_]f64{ 5, 6, 7, 8 }, 2, 2);

    // multiplying
    var result = matrix1.mul(matrix2);

    // show the answer
    std.debug.print("answer of multiplication is :\n", .{});
    for (result.data) |val, i| {
        if (i % 2 == 0) {
            std.debug.print("\n", .{});
        }
        std.debug.print("{d} ", .{val});
    }
    std.debug.print("\n", .{});
}
```
**Update 0.2**
## Functions added in 0.2

* `sigmoid(x: f64) -> f64` Computes the sigmoid activation function.
* `softmax(x: []f64) -> []f64`Computes the softmax activation function.
* `relu(x: f64) -> f64`Computes the rectified linear unit (ReLU) activation function.
* `cross_entropy_loss(y_true: []f64, y_pred: []f64) -> f64` Computes the cross-entropy loss function.

* `mean_squared_error(y_true: []f64, y_pred: []f64) -> f64` Computes the mean squared error (MSE) loss function.
## Example program 2

```zig
const ballin = @import("ballin.zig");

pub fn main() anyerror!void {
    const x = [_]f64{1.0, 2.0, 3.0};
    const y_true = [_]f64{0.5, 0.2, 0.3};
    const y_pred = [_]f64{0.4, 0.3, 0.3};

    const sigmoid_result = ballin.sigmoid(x[0]);
    std.debug.print("Sigmoid result: {}\n", .{sigmoid_result});

    const softmax_result = ballin.softmax(x);
    std.debug.print("Softmax result: {}\n", .{softmax_result});

    const relu_result = ballin.relu(x[0]);
    std.debug.print("ReLU result: {}\n", .{relu_result});

    const cross_entropy_loss_result = ballin.cross_entropy_loss(y_true, y_pred);
    std.debug.print("Cross-entropy loss: {}\n", .{cross_entropy_loss_result});

    const mean_squared_error_result = ballin.mean_squared_error(y_true, y_pred);
    std.debug.print("Mean squared error: {}\n", .{mean_squared_error_result});
}
```






# What Needs to be Implemented



* More machine learning algorithms
* Support for more data types
* A more robust and efficient data structure for the dataset
* Parallel processing and GPU acceleration
* A simple neural network
* More advanced machine learning techniques
* How to Contribute

note that its just a plan for project and even tho I feel pasionate about it, it may be to difficult for me. 


# HOW TO INSTALL????
To install liblary you need to copy `ballin.zig` do the cataloge with project and add this code to `build.zig` file:
```zig
const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable(.{
        .name = "ballin",
        .root_source_file = .{ .path = "ballin.zig" },
        .target = target,
        .optimize = mode,
    });

    exe.linkLibC = true;
    exe.linkSystemLibraryName("c");

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
```

**LICENSE:**
```markdown
MIT License

Copyright (c) 2023 kitajusSus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```



