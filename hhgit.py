# coding=utf-8

import numpy as np
import os.path
from scipy.misc import imread, toimage

# Util to convert png files 30x30 into text file and back
# to setup run in root directory: `pip install -r requirements.txt`


# Usage: to_text(['img/refactoring.png', 'img/feature2.png', 'img/init.png', 'img/bugfix.png'], 'main.data')
# png_filenames - list of filepathes(relative) to png images. Files will be converted
# text_filename - resulting text representation
def to_text(png_filenames, text_filename):
    with open(text_filename, 'w') as text_file:
        for png_filename in png_filenames:
            im = imread(png_filename, flatten=False, mode='RGB')
            for x in range(im.shape[0]):
                for y in range(im.shape[1]):
                    color = tuple(im[y][x])
                    r, g, b = color
                    if not (r == 0 and g == 0 and b == 0):
                        text_file.write("{x};{y};{r};{g};{b}\n".format(x=x, y=y, r=r, g=g, b=b))


# Usage: from_text(['../train_repo/ground.data', '../train_repo/main.data'], 'main.png')
# text_filenames - list of filepathes(relative) to text files with encoded pixel data. Files will be converted
# png_filename - resulting image file
def from_text(text_filenames, png_filename):
    data = np.zeros((30, 30, 3))
    for text_filename in text_filenames:
        if os.path.isfile(text_filename):
            with open(text_filename, 'r') as text_file:
                for point_line in text_file:
                    if point_line and not point_line.startswith('#'):
                        x, y, r, g, b = point_line.split(';')
                        data[int(y), int(x)] = [int(r), int(g), int(b)]
    img = toimage(data)
    img.save(png_filename)
