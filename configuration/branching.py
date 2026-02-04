import os
from netbox_branching.utilities import DynamicSchemaDict

DATABASES = DynamicSchemaDict({
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME':     os.environ["DB_NAME"],          # Database name
        'USER':     os.environ["DB_USER"],          # PostgreSQL username
        'PASSWORD': os.environ["DB_PASSWORD"],      # PostgreSQL password
        'HOST':     os.environ["DB_HOST"],          # Database server
        'PORT':     os.environ["DB_PORT"],          # Database port (leave blank for default)
        'CONN_MAX_AGE': 300,                        # Max database connection age
    }
})

DATABASE_ROUTERS = [
    'netbox_branching.database.BranchAwareRouter',
]
