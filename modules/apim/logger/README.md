APIM Logger
=============

A module to create an APIM Logger to log API Management events

## Variables

The following variables are available:

### region

- __description__: The region to deploy the resources in.
- __default__: "southafricanorth"

### environment

- __description__: The environment that the resources are deployed for.
- __default__: "dev"

### base_name

- __description__: The base name to use for all resources.
- __default__: ""

### rg_name

- __description__: The name of the resource group to deploy in.
- __default__: null

### tags

- __description__: Additional tags to add to the deployed resources.
- __default__: null

### apim_name" 
- __description__: The name of the API Management instance to target.
- __default__: null

### instrumentation_key
- __description__: The instrumentation key from the application insights instance for logging.
- __default__: null

### evh_name
- __description__: The name of the Event Hub instance to target.
- __default__: null

### evh_connection_string
- __description__: The connection string for the Event Hub instance.
- __default__: null
