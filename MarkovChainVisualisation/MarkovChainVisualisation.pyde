"""

MARKOV CHAINS VISUALISATION
driven by processing.py and JSON data

@author Vladimir V KUCHINOV
@email  helloworld@vkuchinov.co.uk

"""

add_library("pdf") 

import json
from Curves import ComplexBezier
from VisualElements import Markov, Lyrics

def setup():

    with open("data.json") as f:
        json_ = json.load(f)
        data = parseJSON(json_)

    chain = Markov(300, 250, 128, data)
    bar = Lyrics(32, 536, 536, 32, data)
    
    size(600, 600)
    background(0xFFFFFF)
    
    #Retina enanled
    #pixelDensity(2)

    noFill()

    beginRecord(PDF, "output.pdf")
        
    chain.render()
    bar.render()
    
    endRecord()
    
def parseJSON(json_):
    
    out = []
    
    for i in range(0, len(json_)):

        out.append(json_[str(i)])
    
    return out
