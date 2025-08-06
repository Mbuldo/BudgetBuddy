resource insights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'budgetbuddy-insights'
  location: 'eastus'
  kind: 'web'  // 
  properties: {
    Application_Type: 'web'
  }
}

output INSTRUMENTATION_KEY string = insights.properties.InstrumentationKey