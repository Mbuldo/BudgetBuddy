import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app.models import Transaction


def test_add_transaction():
    transaction = Transaction(amount=10, category="Food")
    assert transaction.amount == 10
