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
#### Example
```zig
var matrix1 = Matrix.init([_]f64{ 1, 2, 3, 4 }, 2, 2);
var matrix2 = Matrix.init([_]f64{ 5, 6, 7, 8 }, 2, 2);
var result = matrix1.mul(matrix2);
```

# How to use? // Example program
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



