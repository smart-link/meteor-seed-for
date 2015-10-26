Route = FlowRouter.group {}

Route.route '/',
  action: (params, queryParams) ->
    BlazeLayout.render 'welcome'
