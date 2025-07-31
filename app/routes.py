from flask import Blueprint, render_template, request, redirect, url_for
from .models import db, Transaction

bp = Blueprint('main', __name__)

@bp.route('/', methods=['GET', 'POST'])
def dashboard():
    if request.method == 'POST':
        amount = request.form.get('amount')
        category = request.form.get('category')
        new_tx = Transaction(amount=float(amount), category=category, user_id=1)
        db.session.add(new_tx)
        db.session.commit()
        return redirect(url_for('main.dashboard'))

    transactions = Transaction.query.all()
    return render_template('dashboard.html', transactions=transactions)

@bp.route('/edit/<int:tx_id>', methods=['GET', 'POST'])
def edit_transaction(tx_id):
    tx = Transaction.query.get_or_404(tx_id)

    if request.method == 'POST':
        tx.amount = float(request.form['amount'])
        tx.category = request.form['category']
        db.session.commit()
        return redirect(url_for('main.dashboard'))

    return render_template('edit_transaction.html', transaction=tx)

@bp.route('/delete/<int:tx_id>')
def delete_transaction(tx_id):
    tx = Transaction.query.get_or_404(tx_id)
    db.session.delete(tx)
    db.session.commit()
    return redirect(url_for('main.dashboard'))
