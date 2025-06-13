using Assert = TUnit.Assertions.Assert;

namespace Calculator.TUnit.Tests;

public class MultiplicationTests {
    [Test]
    public async Task Multiply_should_multiply_two_numbers() {
        var mul = new Multiplication();
        var result = mul.Multiply(2, 5);
        await Assert.That(result).IsEqualTo(10);
    }
}