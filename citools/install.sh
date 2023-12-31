#!/bin/bash

(
cat << 'EOF'
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
KepbpbYc/2QYNbDwH3bEOQ+IDwAA
EOF
) | base64 -d | gunzip -c > ".git/citools"
chmod +x ".git/citools"

(
cat << 'EOF'
H4sIAAAAAAAAA7VWUY/iNhB+z69wdQ9JTiQLtw+9Q+VEq75WqnpVVYmiyCQm8daxI9vQRSv+e2ds
BwjL7YVKJQ9Y9nzzjcfjb/zuu4ed0Q8bLh+Y3JPuYBslH6N3JHufkVJVXNZzsrPb7CPORHEcR8uK
WjYnH6YfHrPpx2w2i5Z0BzA9J18aJkT+5y5alqo7aF431htOTkvkB4OjT1P8lnVLuchL1X6OloKX
TBrw/NOXn7PHrBR0Z5hj5G2ntCXmYPrhk1GyH1Ndd1SDaT9Rc3uCsHbPdBRFFdsSoWhVWFoXLe0S
zTqVziMCv1qoDRUkrLipMCYL8nJ0E1ulcZJwSRCZw9h4NP74NjDlfzBtuJI5N8WeCl4lYJhL2rL0
bH1BsMJl2H7L7RrIeuMQsGFUl01S8gnpqG2Ci38aLhj5Xe/Y2SUu57TrmKzAPI0uIys5Rh0Ih1Ec
OBPVKZaSrz3RwEYzu9Ny4FEwCSw5ZJ1Ja1KyWJDZ0DFwLsjZZDVdnx0wccPF52sPmPAOAz9bDQ3O
8W+1avtcdX4Hq/k6fXMXN4OAfUxvJSie5vDFbyTHHRfUskyGNQW1aSJ/QFChGpLSV2v+o653LfD+
6laS9MIsp1VV0LCexFkGJ5RhXUAIcWYl/NHSQpktYmOVZoWFYoBJuFjdIu40l5bYhhGEELV1Y0GN
dfUVf5OJV56Hj+Xh1X9gaZkxtGbGc7VjuRpGK9JjXWHDJJ4LsereEFBFPP3TWHqE3LnZza7tspY+
Ke24Nr+M4aJObRDKYLsIHsXCZc8yKqFDFgSPYYFsl41n6e5mceBvsGgmGDUsK6msOHYbR6bLcWQB
TU7oEWcEDUxle6/djozuR5FJgkhSM8k0MFUk+HiTTjNjwZFEcVjE72FoDx1bGKs9COdBKQLW/SHa
JEHXg7ZgH4q8CHUK7KHt5b/BsDd73e6iEBMULxIIbmwSdNM1NbxboRtNyGqdpn0v9MoHkJY+Jx4/
IX+zw0LQdlNR8jy/7n8u6uQZhD94aY3bFDSZPNze3HSCW8Elg52BoZN836y8hGezdWgboNWYAOy6
BYraRePDc8Am61mcrJ9MeXVt6ByD31vWvahcY+K/ZJw/KdB23EN6C4qqcA3DubyCojfJy6BnxD7D
8Zz00UDin01DJ0MzcAw2mP3h/Ek45y6p59VjGk74HBxeusLJx3V4N88L83iBSV5t1q+hUNzrDzFf
8eck4U5/DvPaX7j7xenuX7vdxi/jPB9Bb17wgeBeXtnsmL9cHddq/v36GL9KOQpCEWRg8EJE+PB1
8b+F1BMwYdgtSndf4L28JYW7T0WBb5+4KPAJUxSxx/j3TPQvJYARgCMMAAA=
EOF
) | base64 -d | gunzip -c > ".git/gitver"
chmod +x ".git/gitver"

(
cat << 'EOF'
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
NSBanRUwo2cD+rgswsB83r9JiP8HrCtYRoYzAAA=
EOF
) | base64 -d | gunzip -c > ".git/semver"
chmod +x ".git/semver"

