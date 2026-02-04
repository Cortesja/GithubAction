PLUGINS = [
    'netbox_acls',
    'netbox_floorplan',
    'netbox_qrcode',
    'netbox_reorder_rack',
    'netbox_secrets',
    'netbox_topology_views',
    'slurpit_netbox',
    'netbox_branching',
]

DATABASE = None

from netbox_branching.utilities import DynamicSchemaDict

DATABASES = DynamicSchemaDict({
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME':     environ["DB_NAME"],          # Database name
        'USER':     environ["DB_USER"],          # PostgreSQL username
        'PASSWORD': environ["DB_PASSWORD"],      # PostgreSQL password
        'HOST':     environ["DB_HOST"],          # Database server
        'PORT':     environ["DB_PORT"],          # Database port (leave blank for default)
        'CONN_MAX_AGE': 300,                        # Max database connection age
    }
})

DATABASE_ROUTERS = [
    'netbox_branching.database.BranchAwareRouter',
]
