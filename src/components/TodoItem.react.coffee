React = require 'react'
ReactPropTypes = React.PropTypes
TodoActions = require '../actions/TodoActions'
TodoTextInput = require './TodoTextInput.react'
cx = require 'react/lib/cx'

TodoItem = React.createClass
  propTypes:
      todo: ReactPropTypes.object.isRequired
  getInitialState: -> isEditing:false
  render: ->
    todo = @.props.todo
    input = undefined
    if @.state.isEditing
      input = TodoTextInput(
        className: 'edit'
        onSave: @._onSave
        value: todo.text
      )

    ### List items should get the class 'editing' when editing
      and 'completed' when marked as completed.
      Note that 'completed' is a classification while 'complete' is a state.
      This differentiation between classification and state becomes important
      in the naming of view actions toggleComplete() vs. destroyCompleted(). ###

#    React.DOM.li
#      className: cx
#          completed: todo.complete
#          editing: @.state.isEditing
#      key: todo.id
#      , React.DOM.div
#          className: 'view'
#          , [
#            React.DOM.input
#              className: 'toggle'
#              type: 'checkbox'
#              checked: todo.complete
#              onChange: @._onToggleComplete
#            React.DOM.label onDoubleClick:@._onDoubleClick , todo.text
#            React.DOM.button className:'destroy', onClick:@._onDoubleClick
#            ]
#      , input

    `<li
        className={cx({
            'completed': todo.complete,
            'editing': this.state.isEditing
          })}
        key={todo.id}>
        <div className="view">
            <input
                className="toggle"
                type="checkbox"
                checked={todo.complete}
                onChange={this._onToggleComplete}
                />
            <label onDoubleClick={this._onDoubleClick}>
                {todo.text}
            </label>
            <button className="destroy" onClick={this._onDestroyClick} />
        </div>
        {input}
    </li>`

  _onToggleComplete: -> TodoActions.toggleComplete @.props.todo

  _onDoubleClick: -> @.setState isEditing: true

  ###
   * Event handler called within TodoTextInput.
   * Defining this here allows TodoTextInput to be used in multiple places
   * in different ways.
   * @param  {string} text
   ###
  _onSave: (text) ->
    TodoActions.updateText @.props.todo.id, text
    @.setState isEditing: false

  _onDestroyClick: -> TodoActions.destroy @.props.todo.id

module.exports = TodoItem
