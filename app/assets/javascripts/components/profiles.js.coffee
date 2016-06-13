@Profiles = React.createClass
  getInitialState: ->
    profiles: @props.data
  getDefaultProps: ->
    profiles: []
  render: ->
    React.DOM.div
      className: 'profiles'
      React.DOM.h2 null,
        'Profiles'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'ID'
            React.DOM.th null, 'Name'
            React.DOM.th null, 'Status'
            React.DOM.th null, 'City'
            React.DOM.th null, 'Rating'
            React.DOM.th null, 'Rank'
            React.DOM.th null, 'Sent At'
        React.DOM.tbody null,
          for profile in @state.profiles
            React.createElement Profile, key: profile.id, profile: profile
