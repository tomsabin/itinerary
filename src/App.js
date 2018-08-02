import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class NewItineraryAction extends Component {
  initialState = {
    name: '',
    toggled: false
  }

  constructor(props) {
    super(props)
    this.state = this.initialState
  }

  handleToggleClick(event) {
    event.preventDefault()
    this.setState(prevState => (
      {
        name: '',
        toggled: !prevState.toggled
      }
    ))
  }

  handleChange(event) {
    this.setState({
      name: event.target.value
    })
  }

  handleSubmit(event) {
    event.preventDefault()
    const name = this.state.name
    if (name === '') return
    if (this.props.checkDuplicateName(name)) return
    this.props.onSubmit(name)
    this.setState(this.initialState)
  }

  render() {
    if (this.state.toggled) {
      return (
        <form onSubmit={this.handleSubmit.bind(this)}>
          <input
            required
            autoFocus
            type="text"
            name="name"
            value={this.state.name}
            onChange={this.handleChange.bind(this)} />
          <input
            type="submit"
            value="Save" />
          <button
            type="button"
            onClick={this.handleToggleClick.bind(this)}>
            Cancel
          </button>
        </form>
      )
    }

    return (
      <button onClick={this.handleToggleClick.bind(this)}>
        New itinerary
      </button>
    )
  }
}

class ItineraryListItem extends Component {
  render() {
    return (
      <li>
        {this.props.name}
        <button onClick={this.props.onRemoveClick.bind(this, this.props.name)}>
          Delete
        </button>
      </li>
    )
  }
}

class App extends Component {
  state = {
    itineraries: []
  }

  componentDidMount() {
    const localItems = localStorage.getItem('itineraries')
    if (localItems == null) return

    this.setState({ itineraries: JSON.parse(localItems) })
  }

  handleAddItinerary(name) {
    this.setState(prevState => (
      { itineraries: [...prevState.itineraries, name] }
    ), () => {
      localStorage.setItem('itineraries', JSON.stringify(this.state.itineraries))
    })
  }

  handleRemoveItinerary(name) {
    if (!window.confirm(`Are you sure you delete "${name}"?`)) return

    this.setState(prevState => (
      { itineraries: prevState.itineraries.filter(x => x !== name) }
    ), () => {
      localStorage.setItem('itineraries', JSON.stringify(this.state.itineraries))
    })
  }

  checkDuplicateName(name) {
    return this.state.itineraries.includes(name)
  }

  render() {
    return (
      <div>
        <ol>
        {
          this.state.itineraries.map(name => (
            <ItineraryListItem
              key={name}
              name={name}
              onRemoveClick={this.handleRemoveItinerary.bind(this)} />
          )
        )}
        </ol>
        <NewItineraryAction
          checkDuplicateName={this.checkDuplicateName.bind(this)}
          onSubmit={this.handleAddItinerary.bind(this)} />
      </div>
    );
  }
}

export default App;
