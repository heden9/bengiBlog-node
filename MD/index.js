import React, { Component } from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import '../scss/waterfall.scss';

class Waterfall extends Component {
  static times = 0;
  static timeList = [];
  static fn(props){
    console.log('fn');
    console.log(Waterfall.times);
    Waterfall.timeList.push(Waterfall.times);
    let name = props.status;
    return (<div className={classnames(['leading-item', `${name}`
    ])}>
    <div className="leading-item-ball">{Waterfall.times++ }</div>
    <h6 className="leading-item-title">{props.title}</h6>
    </div>);
  }
  componentWillMount() {
    console.log('12');
  }
  render() {
        const { current, children } = this.props;
        console.log(current);
        return (
          <div>{ children }</div>
        );
  }
}





export default Waterfall;

import React, { Component } from 'react';
import Waterfall from '../../src/js/index';
import './app.scss';
class App extends Component {
    render() {
        const Card = Waterfall.fn;
        return  (<div className="intro">
            <Card title="Finished" status="Finished" />
            <Card title="Progressing" status="Finished"/>
            <Card title="Waiting" status="Processing"/>
            <Card title="完成" status="waiting" />
        </div>
        );

    }
}
export default App
