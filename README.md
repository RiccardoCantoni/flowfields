# flowfields

generation parameters are in the SETTINGS section of "flowfield.pde". here is an explaination of the less self descriptive parameters

## noise generation
PERLIN_SAMPLING_SCALE is the scale at which noise is sampled. default is 0.0025. larger values produce a more jagged and irregular output. smaller values produce a smoother flowfield. PERLIN_POW is a flattening factor for the noise values. the larger it is, the flatter the distribution of noise values becomes. the smaller it is, the more concentrated towards the mean (0.5) it is.

## color management 

PERLIN_COLOR allows for a multi coloured output. if set to True then the colour assigned to each particle is a linear interpolation between NEG and POS colors, using noise as parameter.  if set to False, only NEG colors are used. START_NEG is the color of the begginning of a particle trail, while END_NEG is the color of the end of the trail.

## saving the output

OUTPUT_IMAGE can be set to null to disable saving the output.
