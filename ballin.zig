const std = @import("std");

pub const Tensor = struct {
    data: []f64,
    shape: []usize,

    pub fn init(data: []f64, shape: []usize) Tensor {
        return Tensor{
            .data = data,
            .shape = shape,
        };
    }

    pub fn mul(self: Tensor, other: Tensor) Tensor {
        assert(self.shape.len == other.shape.len);
        var result = try std.ArrayList(f64).initCapacity(std.heap.page_allocator, self.shape[0] * other.shape[1]);
        errdefer result.deinit();

        for (self.data) |val, i| {
            for (other.data) |oval, j| {
                result.append(val * oval);
            }
        }

        return Tensor.init(result.items, self.shape);
    }
};

pub const Matrix = struct {
    data: []f64,
    rows: usize,
    cols: usize,

    pub fn init(data: []f64, rows: usize, cols: usize) Matrix {
        return Matrix{
            .data = data,
            .rows = rows,
            .cols = cols,
        };
    }

    pub fn mul(self: Matrix, other: Matrix) Matrix {
        assert(self.cols == other.rows);
        var result = try std.ArrayList(f64).initCapacity(std.heap.page_allocator, self.rows * other.cols);
        errdefer result.deinit();

        for (self.data) |val, i| {
            for (other.data) |oval, j| {
                result.append(val * oval);
            }
        }

        return Matrix.init(result.items, self.rows, other.cols);
    }
};

test "tensor mul" {
    var tensor1 = Tensor.init([_]f64{ 1, 2, 3 }, [_]usize{ 3 });
    var tensor2 = Tensor.init([_]f64{ 4, 5, 6 }, [_]usize{ 3 });
    var result = tensor1.mul(tensor2);
    try std.testing.expectEqualSlices(f64, result.data, [_]f64{ 4, 10, 18 });
}

test "matrix mul" {
    var matrix1 = Matrix.init([_]f64{ 1, 2, 3, 4 }, 2, 2);
    var matrix2 = Matrix.init([_]f64{ 5, 6, 7, 8 }, 2, 2);
    var result = matrix1.mul(matrix2);
    try std.testing.expectEqualSlices(f64, result.data, [_]f64{ 19, 22, 43, 50 });
}



pub fn sigmoid(x: f64) -> f64 {
    return 1.0 / (1.0 + std.math.exp(-x));
}

pub fn softmax(x: []f64) -> []f64 {
    var sum: f64 = 0.0;
    for (x) |val| {
        sum += std.math.exp(val);
    }
    var result: []f64 = undefined;
    for (x) |val| {
        result = result ++ [1]f64{std.math.exp(val) / sum};
    }
    return result;
}

pub fn relu(x: f64) -> f64 {
    if (x > 0.0) {
        return x;
    } else {
        return 0.0;
    }
}

pub fn cross_entropy_loss(y_true: []f64, y_pred: []f64) -> f64 {
    var loss: f64 = 0.0;
    for (y_true) |val_true, i| {
        loss += val_true * std.math.log(y_pred[i]);
    }
    return -loss;
}

pub fn mean_squared_error(y_true: []f64, y_pred: []f64) -> f64 {
    var loss: f64 = 0.0;
    for (y_true) |val_true, i| {
        loss += (val_true - y_pred[i]) * (val_true - y_pred[i]);
    }
    return loss / @intToFloat(f64, y_true.len);
}
