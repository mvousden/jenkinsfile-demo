from complicated_library import addition

def test_addition():
    """
    Tests the addition function.
    """

    assert addition(-3, 4) == 1


if __name__ == "__main__":
    print("Testing addition...")
    test_addition()
    print("Test passed!")
