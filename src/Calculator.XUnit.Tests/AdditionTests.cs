namespace Calculator.XUnit.Tests;

public class AdditionTests {
    [Fact]
    public void Addition_should_add_two_numbers() {
        var a = new Addition();
        var result = a.Add(2, 5);
        Assert.Equal(7, result);
    }
}