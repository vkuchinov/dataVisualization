import React from 'react'
import PropTypes from 'prop-types';

class CircularNode extends React.Component{
           
    render() {

        let {prefix, index, data} = this.props;

        let tspans = data.label.split("|").map((d_, i_) =>{
            
            let halfTextHeight = data.fontStyle.size * data.label.split("|").length / 2;
            let key = 'vennDiagramCircularNode' + index + '_Tspan' + i_;
    
            return (
            
                <tspan key={key} x={data.offset.x} y={data.offset.y - halfTextHeight + i_ * data.fontStyle.size}>{d_}</tspan>
                
            )
            
        })
        
        let translate = 'translate(' + data.cx + ',' + data.cy + ')';
        
        return ( 
            
            <g transform={translate}>
            <circle
            
                id={this._reactInternalFiber.key}
                className={'circularNode'}
                ref={prefix + 'Node_' + index}
                data-tooltip={data.tooltip}
                r={data.r}
                opacity={0.8}
                fill={data.hex}
    
            />
            <text textAnchor='middle' fill={data.fontStyle.color} dominantBaseline={'middle'} fontSize={data.fontStyle.size + 'px'} pointerEvents={'none'}>
            {tspans}
            </text>
            </g>
            
        )
        
    }
    
}

CircularNode.propTypes = {
        
      prefix: PropTypes.string,
      index: PropTypes.number,
      data: PropTypes.object
        
}

export default CircularNode;