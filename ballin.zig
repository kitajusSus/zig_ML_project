const std = @import("std");

pub fn sigmoid(x: f64) -> f64 {
    return 1.0 / (1.0 + std.math.exp(-x));
}

pub fn sigmoid_derivative(x: f64) -> f64 {
    return x * (1.0 - x);
}

pub fn relu(x: f64) -> f64 {
    return if (x > 0.0) x else 0.0;
}

pub fn relu_derivative(x: f64) -> f64 {
    return if (x > 0.0) 1.0 else 0.0;
}

pub fn tanh(x: f64) -> f64 {
    return 2.0 / (1.0 + std.math.exp(-2.0 * x)) - 1.0;
}

pub fn tanh_derivative(x: f64) -> f64 {
    return 1.0 - x * x;
}

pub fn softmax(x: []f64) -> []f64 {
    var sum: f64 = 0.0;
    for (x) |val| {
        sum += std.math.exp(val);
    }
    var result: []f64 = undefined;
    result.len = x.len;
    for (x) |val, i| {
        result[i] = std.math.exp(val) / sum;
    }
    return result;
}

pub fn NeuralNetwork {
    layers: [][]f64,
    weights: [][]f64,
    biases: [][]f64,
    optimizer: Optimizer,

    pub fn init(layers: [][]f64, weights: [][]f64, biases: [][]f64, optimizer: Optimizer) -> NeuralNetwork {
        return NeuralNetwork{
            .layers = layers,
            .weights = weights,
            .biases = biases,
            .optimizer = optimizer,
        };
    }

    pub fn forward(self: *NeuralNetwork, inputs: []f64) -> []f64 {
        var layer: []f64 = inputs;
        for (self.layers) |_, i| {
            layer = dot(layer, self.weights[i]) + self.biases[i];
            layer = switch (i) {
                0 => sigmoid(layer),
                1 => relu(layer),
                else => tanh(layer),
            };
        }
        return layer;
    }

    pub fn train(self: *NeuralNetwork, inputs: []f64, targets: []f64) -> void {
        var layer: []f64 = inputs;
        var errors: [][]f64 = undefined;
        errors.len = self.layers.len;
        for (self.layers) |_, i| {
            layer = dot(layer, self.weights[i]) + self.biases[i];
            layer = switch (i) {
                0 => sigmoid(layer),
                1 => relu(layer),
                else => tanh(layer),
            };
            errors[i] = targets - layer;
        }
        self.optimizer.update(self, errors);
    }
};

pub fn Optimizer {
    learning_rate: f64,

    pub fn init(learning_rate: f64) -> Optimizer {
        return Optimizer{
            .learning_rate = learning_rate,
        };
    }

    pub fn update(self: *Optimizer, nn: *NeuralNetwork, errors: [][]f64) -> void {
        for (nn.layers) |_, i| {
            nn.weights[i] += self.learning_rate * dot(transpose(nn.layers[i]), errors[i]);
            nn.biases[i] += self.learning_rate * errors[i];
        }
    }
};

pub fn dot(a: []f64, b: []f64) -> []f64 {
    var result: []f64 = undefined;
    result.len = a.len;
    for (a) |aval, i| {
        result[i] = 0.0;
        for (b) |bval, j| {
            result[i] += aval * bval;
        }
    }
    return result;
}

pub fn transpose(a: []f64) -> []f64 {
    var result: []f64 = undefined;
    result.len = a.len;
    for (a) |aval, i| {
        result[i] = 0.0;
        for (a) |bval, j| {
            result[i * a.len + j] = aval * bval;
        }
    }
    return result;
}

pub fn conv2d(input: []f64, kernel: []f64, stride: u32) -> []f64 {
    var output: []f64 = undefined;
    output.len = (input.len - kernel.len) / stride + 1;
    for (input) |ival, i| {
        for (kernel) |kval, j| {
            output[i / stride * output.len + j / stride] += ival * kval;
        }
    }
    return output;
}

pub fn max_pooling(input: []f64, kernel_size: u32, stride: u32) -> []f64 {
    var output: []f64 = undefined;
    output.len = (input.len - kernel_size) / stride + 1;
    for (input) |ival, i| {
        var max: f64 = ival;
        for (input) |jval, j| {
            if (j >= i and j < i + kernel_size) {
                if (jval > max) {
                    max = jval;
                }
            }
        }
        output[i / stride] = max;
    }
    return output;
}

pub fn dropout(input: []f64, probability: f64) -> []f64 {
    var output: []f64 = undefined;
    output.len = input.len;
    for (input) |ival, i| {
        if (std.math.random.float(f64) < probability) {
            output[i] = 0.0;
        } else {
            output[i] = ival;
        }
    }
    return output;
}
