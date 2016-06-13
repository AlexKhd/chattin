@Comment = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.comment.rating
      React.DOM.td null, @props.profile.name
      React.DOM.td null, @props.profile.status
      React.DOM.td null, @props.profile.city
      React.DOM.td null, @props.profile.rating
      React.DOM.td null, @props.profile.rank
      React.DOM.td null, @props.profile.news_email_sent_at
