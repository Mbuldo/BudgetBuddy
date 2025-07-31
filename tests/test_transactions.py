def test_add_transaction():
    transaction = Transaction(amount=10, category="Food")
    assert transaction.amount == 10