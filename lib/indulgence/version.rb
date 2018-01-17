module Indulgence
  VERSION = "0.2.0"
end

# History
# =======
#
# 0.2.0   Updated to work with ActiveRecord 5.
#
# 0.1.2   Adds strict mode - to allow more flexible use (if a none user object
#         is passed to indulge?, in strict mode a no method error is raised. When
#         indulgence.strict = false, indulge? will use the default abilities)
#
# 0.1.1   Makes it easier to use the state of an object to determine permissions
#         rather than a user's role.
#
# 0.1.0   Handles a nil entity being passed to either indulge? or indulgence.
#         Code now tried and tested in a number of applications, so
#         bumping up to 0.1.
#
# 0.0.7   Adds Thing.indulge? class method.
#
# 0.0.6   Specifies the default behaviour as assigning the none ability to
#         all CRUD actions.
#
# 0.0.5   Allows simplified ability definition to be used with has_many
#
# 0.0.4   Simplifies defining abilities
#
#         Allows and ability to be defined by passing in the name of the
#         association that it refers to.
#
# 0.0.3   Updated to use latest version of standalone_migrations
#
#         Branch this app has been using has been merged into standalone_migrations
#         main. So config in .standalone_migrations now works without
#         using a specific clone branch.
#
# 0.0.2   Rebuild with lessons learnt from first usage in host app
#
#         Adds automatic caching of abilites. Required a reworking of ability
#         lambdas, so that a particular entity id wasn't cached
#
#         Renamed ability methods truth as compare_single, and where_clause as
#         filter_many as more descriptive.
#
#         Forced Ability methods #compare_single and #filter_many to use lambdas
#         (or other object that responds to call). The reasons:
#
#           1. To remove the special way that the none ability was handled.
#           2. Previously, if Ability#filter_many was nil everything would be returned,
#              which I think is counter-intuitive.
#           3. Also if Ability#filter_many was undefined, then everything would
#              be returned, which is just poor design for a permission tool. Now
#              an error is raised.
#
# 0.0.1   Initial build
#         First alpa version
#
