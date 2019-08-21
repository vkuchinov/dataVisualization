<h1>VENN DIAGRAM REACTJS</h1>
<br><br>

```
import VennDiagram from '../VennDiagram'
```

...

```
let mockup = [

{
    "Conclusive": 4,
    "Inconclusive": 0,
    "Positive": 1,
    "Unexecuted": 2,
    "pillar": "Data"
},
{
    "Conclusive": 0,
    "Inconclusive": 5,
    "Positive": 0,
    "Unexecuted": 2,
    "pillar": "People"
},
{
    "Conclusive": 0,
    "Inconclusive": 0,
    "Positive": 6,
    "Unexecuted": 3,
    "pillar": "Networks"
},
{
    "Conclusive": 2,
    "Inconclusive": 0,
    "Positive": 1,
    "Unexecuted": 1,
    "pillar": "Devices"
},
{
    "Conclusive": 0,
    "Inconclusive": 0,
    "Positive": 0,
    "Unexecuted": 0,
    "pillar": "Workloads"
},
{
    "Conclusive": 0,
    "Inconclusive": 2,
    "Positive": 0,
    "Unexecuted": 0,
    "pillar": "Visibility & Analytics"
},
{
    "Conclusive": 0,
    "Inconclusive": 0,
    "Positive": 0,
    "Unexecuted": 0,
    "pillar": "Automation & Orchestration"
}

];
```

...

```
return (

	<VennDiagram pillarsGrades={mockup} />

)
```
