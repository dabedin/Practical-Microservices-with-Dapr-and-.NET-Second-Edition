# replace value before starting
$RESOURCE_GROUP = ""
$REGISTRY_NAME = ""
$APPLICATIONINSIGHTS_NAME = ""
$LOG_ANALYTICS_WORKSPACE = ""
$LOCATION = ""

# create azure log analytics workspace
az monitor log-analytics workspace create --resource-group $RESOURCE_GROUP --workspace-name $LOG_ANALYTICS_WORKSPACE
$LOG_ANALYTICS_WORKSPACE_CLIENT_ID=(az monitor log-analytics workspace show --query customerId -g $RESOURCE_GROUP -n $LOG_ANALYTICS_WORKSPACE --out tsv)
$LOG_ANALYTICS_WORKSPACE_CLIENT_SECRET=(az monitor log-analytics workspace get-shared-keys --query primarySharedKey -g $RESOURCE_GROUP -n $LOG_ANALYTICS_WORKSPACE -o tsv)

# enable application insights extension
az extension add -n application-insights

# create application insights https://docs.microsoft.com/en-us/azure/azure-monitor/app/create-workspace-resource
az monitor app-insights component create --app $APPLICATIONINSIGHTS_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --workspace $LOG_ANALYTICS_WORKSPACE
