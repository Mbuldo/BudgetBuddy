# BudgetBuddy

A personal finance tracker built with Flask and SQLite for managing your spending and gaining financial insights.

## Features

- Dashboard with transaction overview
- Add, edit, and delete transactions
- Category-based expense tracking
- SQLite database for local data storage
- Responsive web interface

## Prerequisites

- Python 3.8+
- Virtual environment (recommended)

## Local Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Mbuldo/BudgetBuddy.git
   cd BudgetBuddy
   ```

2. **Create and activate virtual environment**
   ```bash
   python -m venv bb-venv
   source bb-venv/bin/activate  # On Windows: bb-venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Initialize the database**
   ```bash
   python init_db.py
   ```

5. **Run the application**
   ```bash
   # Option 1: Using Flask CLI
   flask run --host=0.0.0.0
   
   # Option 2: Direct Python execution
   python app.py
   ```

6. **Access the application**
   - Local: http://127.0.0.1:5000
   - Network: http://192.168.100.4:5000

## Project Structure

```
BudgetBuddy/
├── app/
│   ├── __init__.py          # Flask app factory
│   ├── models.py            # Database models
│   ├── routes.py            # Application routes
│   └── templates/           # HTML templates
├── instance/
│   └── budgetbuddy.db      # SQLite database (auto-created)
├── tests/
│   └── test_transactions.py
├── terraform/              # Infrastructure as code
├── app.py                  # Application entry point
├── init_db.py             # Database initialization
├── requirements.txt       # Python dependencies
└── README.md
```

## Database

The application uses SQLite for data storage. The database file (`budgetbuddy.db`) is automatically created when you run `init_db.py`.

## Development

- **Debug mode**: The app runs in debug mode by default for development
- **Database changes**: Run `python init_db.py` after model changes
- **Testing**: Run tests with `python -m pytest tests/`

## Docker Support

Alternative setup using Docker:

```bash
docker-compose up --build
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

## Deployment
1. Build image: `docker build -t budgetbuddy .`
2. Push to ACR: `docker push budgetbuddyacr.azurecr.io/budgetbuddy:latest`
3. Deploy: `terraform apply`

### Monitoring Setup

Alerts were configured manually using:
```bash
# HTTP Error Alert
az monitor metrics alert create \
  --name "HighHTTPErrors" \
  --resource-group myRG \
  --scopes $(az webapp show --name budgetbuddy-prod --resource-group myRG --query id -o tsv) \
  --condition "total Http5xx > 0" \
  --severity 3