
from app import create_app
import logging
from flask import Flask
import os
from opencensus.ext.azure.trace_exporter import AzureExporter # type: ignore
from opencensus.trace.samplers import ProbabilitySampler # type: ignore
from opencensus.trace.tracer import Tracer # type: ignore

AZURE_MONITOR_KEY = "InstrumentationKey=74d770f9-854f-4ba4-938f-b8013ea36187"
app = create_app()

if __name__ == '__main__':
    app.run(debug=True)

app = Flask(__name__)

logging.basicConfig(
    filename='app.log',
    level=logging.INFO,
    format='%(asctime)s %(levelname)s: %(message)s'
)

if os.environ.get('ENV') == 'production':
    from opencensus.ext.azure.log_exporter import AzureLogHandler # type: ignore
    logger = logging.getLogger(__name__)
    logger.addHandler(AzureLogHandler(
        connection_string=AZURE_MONITOR_KEY
    ))

@app.route('/')
def home():
    app.logger.info('Homepage accessed')  
    return "BudgetBuddy Home"


tracer = Tracer(
    exporter=AzureExporter(
        connection_string="InstrumentationKey=YOUR_KEY"
    ),
    sampler=ProbabilitySampler(1.0)
)

@app.route('/transaction')
def add_transaction():
    with tracer.span(name='add_transaction'):
        
        return "Transaction logged"
    