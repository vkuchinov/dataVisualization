# Neural Network Playground Front-End for Keras

[![Keras](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/keras.png?raw=true)](https://keras.io/) [![TensorFlow](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/tensorflow.png?raw=true)](https://www.tensorflow.org/)[![D3.JS](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/d3.png?raw=true)](https://d3js.org/)

![Build Status](https://img.shields.io/badge/stability-work_in_progress-lightgrey.svg)

This neural network playrgound was inspired by TensorFlow playground, created by  Daniel Smilkov and Shan Carter from Google and inherits its visual aesthetics only.

![UI/UX](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/screenshot.png?raw=true)

Since, my friendly collaborator M., who was working on Python back-end server, couldn't do his job well and didn't develop:  1. data exchange between server-side and browser, 2. didn't follow my JSON structure syntax and 3. didn't 

  - a reliable data exchange between server-side and browser
  - neither didn't follow my provided JSON structure syntax nor proposed his own
  - haven't answer my question is it possible to start calculations from any epoch by knowing previous results, or you have always start from zero stage.
 
The only thing I could do in this case is to generate a mockup data for at least 5 epochs and make an interactive workable demo for those functions which use these values and parameters.

# The Mockup JSON data

First of all, the JSON objects has nclude all neurons, including 8 inputs with same parameters as hidden/output have. That's a key point!

Second, as I have already mentioned, there are five 'pre-calculated' epochs. It could be 20, 50 or even 99 epochs. In this case, the transitions between epochs (animation) would be really fast.

Third, there is no need for really precise floats in any of variables. Originally, M. exported values with 12 numbers after decimal point (0.123456789012). It's f$#^&n a lot. 
D3.JS visualisation doesn't need it. For example, the file with 1000 values 1E-12 is 15K agains 1E-4 (0.1234) of 7K. Reading/loading test is 0.082ms vs. 0.0015ms.

```
{
    parameters: {},
    options: [],
    input: [],
    
    epochs: [1, 5], //range, could be 34-87
    acc: [n], 
    loss: [n],
    val_acc: [n],
    val_loss: [n],
    confusion: [n], //confusion 2D matrix 
    
    neurons: [], //input, hidden and output
    synapses: [] //links between neurons
}
```
The parameters attribute has sliders settings, now the code bypassing it.

The options attribute has all top options, the code builds top control panel based on this data. For example, Resolution parameter

```
 {
		"id": "resolution",
		"label": "Resolution",
		"options": [{
			"o": 3,
			"l": "3x3"
		}, {
			"o": 5,
			"l": "5x5"
		}, {
			"o": 8,
			"l": "8x8"
		}, {
			"o": 16,
			"l": "16x16"
		}],
		"default": 1
	}

```

The input attribute stands for left input visualisation. Whilte it's always the same, it doesn't change through epochs.

```
"points": [{

			"x": -1.9002,
			"y": -2.7564,
			"v": 0.32
		}, {
			"x": 1.5799,
			"y": -1.7250,
			"v": 0.67
		}, {
			"x": 5.0602,
			"y": -0.6936,
			"v": 0.15
		}, {
			"x": 8.5405,
			"y": 0.3377,
			"v": 0.5
		}, {
			"x": 12.0207,
			"y": 1.3690,
			"v": 0.87
		}],

		"values": [0.4841, 0.9935, 0.9313, 0.6164, 0.9142, 0.1077, 0.4665, 0.1993, 0.0599]
```

By now it has both pattern and points. The hybrid mode allows to visualize both in the same time.

The epoch attribute is the range, it could be from 0 (actually 1) to n, or an arbitrary one.
While, current mockup data has only 5 epochs the following arrays has the lenngth of 5

```
acc: [0.7146, 0.5904, 0.3753, 0.6156, 0.19],
loss: [0.5363, 0.05363, 0.7363, 0.5264, 0.5],
val_loss: [0.6680, 0.6380, 0.6230, 0.5680, 0.5507],
val_acc: [0.5363, 0.5063, 0.5363, 0.5063, 0.4936]
```

So, the running player reads them one by one and forms the loss graph (acc, loss).

![Keras](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/graph.gif?raw=true)

The confusion matrix could be any size—2x2, 4x4 or even 3x5. The code would render it correctly. Unfortunately, M. didn't say anything about confusion matrix and its progress through epochs.

By now, it's one for every evolution step.

```
"confusion": [
		[4, 10, 0],
		[1, 96, 2],
		[0, 22, 6]
	],
```

If you need to have a unique one for every epoch, the structure would be

```
"confusion": [
		[[4, 10, 0],
		[1, 96, 2],
		[0, 22, 6]],
		
		[[3, 0.4, 0],
		[1, 16, 2],
		[0, 20, 6]],
		
		[[4, 1, 0],
		[1, 60, 2],
		[1, 2, 61]],
		
		[[1, 33, 5],
		[1, 96, 2],
		[0, 22, 2]],
		
		[[1, 10, 6],
		[1, 69, 2],
		[4, 32, 5]]
	]
```
So every set for every evoluton. Should be clear.

Here comes the neurons. The neuron structure looks like this

```
{
    "layer": 0,
    "node": 1,
    "values": [
    
    [0.1966, 0.3363, 0.5899, 0.2699, 0.0064, 0.4836, 0.3187, 0.7447, 0.0300, 0.2418, 0.8726, 0.8065, 0.6989, 0.7037, 0.4799, 0.1594, 0.7020, 0.5563, 0.6018, 0.3435, 0.8782, 0.0440, 0.0781, 0.7438, 0.4823],

    [0.2705, 0.3955, 0.6173, 0.2703, 0.0000, 0.4553, 0.2639, 0.6671, 0.0000, 0.1533, 0.7738, 0.7006, 0.5890, 0.5805, 0.3451, 0.0258, 0.5783, 0.4422, 0.4931, 0.2285, 0.7578, 0.0000, 0.0000, 0.6495, 0.4056],

    [0.3444, 0.4548, 0.6449, 0.2709, 0.0000, 0.4270, 0.2092, 0.5893, 0.0000, 0.0648, 0.6749, 0.5947, 0.4792, 0.4574, 0.2102, 0.0000, 0.4545, 0.3282, 0.3845, 0.1133, 0.6372, 0.0000, 0.0000, 0.5533, 0.3293],

    [0.4183, 0.5139, 0.6725, 0.2714, 0.0000, 0.3988, 0.1544, 0.5116, 0.0000, 0.0000, 0.5759, 0.4888, 0.3693, 0.3343, 0.0754, 0.0000, 0.3308, 0.2141, 0.2759, 0.0000, 0.5168, 0.0000, 0.0000, 0.4574, 0.2531],

    [0.4922, 0.5732, 0.7001, 0.2720, 0.0000, 0.3702, 0.0993, 0.4338, 0.0000, 0.0000, 0.4775, 0.3830, 0.2592, 0.2110, 0.0000, 0.0000, 0.2070, 0.1000, 0.1672, 0.0000, 0.3970, 0.0000, 0.0000, 0.3654, 0.1761]

],
"bias": [0.5721, 0.4995, 0.1168, 0.8064, 0.1019]
}
```
By now, each neuron pattern is 5x5, excluding output 3x3. 5x5 matrix gives us 25 values, but as you can see, there are 5 x 25, one sequence for each epoch from 1 to 5.

The same for synapses—one value for every pre-calculated epoch.

```
{
	"from_layer": 1,
	"source": 5,
	"target": 5,
	"weight": [0.7488, 0.9781, 0.7419, 0.7965, 0.8706]
}
```

While, M. didn't do, actually we didn't even discussed it, any functions for adding/removing hidden neurons and layers, the UI part for doing it could be considered as placeholders.
The same for sliders.

The only interaction which could be done at this stage is a player along with some minor actions.

[![IMAGE ALT TEXT](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/screenshot.png?raw=true "Demo")
click on top of this screenshot to see video ⇪ 

# The Mockup JSON data

Despite TensorFlow Playground, the current layout is built by grids and guidelines.

![UI/UX](https://github.com/vkuchinov/dataVisualization/blob/master/NeuralNetworks/references/grids.png?raw=true)

In this case, most of rendering functions have grids units, instead of pixels or ems.

For example, drawConfusionMatrix(matrix_, gx_, gy_, gw_, gh_, offset_), where gx_, gy_, gw_ and gh_ are mesaured in grids, so if you want to place the confusion matrix at second row and third column and size 1x1, you have to call drawConfusionMatrix({data}, 3, 2, 1, 1);

The Grids objects has several helpers, like getXByCol(value), getYByRow(value), getWidthByCols(value1, value2), getHeightByRows(value1, value2), which return standard XY coordinates in pixels.

grids.show() shows the guidelines
grids.hide() hides them

If you want to set gaps between blocks, just replace gap with any value at config.json

```
"grids" : { "cols" : 32, "rows" : 16, "gap" : 0 },
```
# config.json

The general setting for the whole D3.JS widget, like overall width, height and colour schemes.



