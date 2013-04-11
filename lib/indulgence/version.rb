module Indulgence
  VERSION = "0.0.2"
end

# History
# =======
# 
# 0.0.2   Rebuild with lessons learnt from first usage in host app
# 
#         Adds automatic caching of abilites. Required a reworking of ability 
#         lambdas, so that a particular entity id wasn't cached
#         
#         Renamed ability methods truth as indugle, and where_clause as indulgence
#         to give consistency between the ability method and the permission
#         method it affects.
#         
#         Forced Ability methods #indulge and #indulgence to use lambdas (or
#         other object that responds to call). The reasons:
#         
#           1. To remove the special way that the none ability was handled.
#           2. Previously, if Ability#indulgence was nil everything would be returned,
#              which I think is counter-intuitive.
#           3. Also if Ability#indulgence was undefined, then everything would
#              be returned, which is just poor design for a permission tool. Now
#              an error is raised. 
# 
# 0.0.1   Initial build
#         First alpa version
#