#  Introduction

This repo involves a simple script for conversion of  `torch_mlir`  based affine dialect to `dot`  format graphical visualized  layout

However, only pass matrix-multiplication algorithm as an incubator projects at the beginning. For sake of further extensive and robust use, several sightly modifications  may applied on match  [specific identifiers](https://github.com/anniezfy/Torch_Affine_To_DOT/blob/main/MlirConversionDot/main.cpp#L82C1-L82C12)

For the clear readability，line-by-line comment 

# Per-requisites

1. The source MLIR file has been generated using Torch-MLIR. Make sure to clone the appropriate version of the LLVM project, which is frequently updated.

   You may access right version of MLIR through following path:

   1.1 directly `git clone` from this repo

​	use the following command:

```bash
git clone --recursive  https://github.com/anniezfy/Torch_Affine_To_DOT.git

cd thrid-party;

git submodule init;

git submodule update;

```

​       Now, install LLVM/MLIR according to https://mlir.llvm.org/getting_started/

​     1.2  directly `git clone` from LLVM project, we use the 5341d5465dbf0b35c64c54f200af8389a8b76aef commit

```bash
git clone https://github.com/llvm/llvm-project.git

git checkout 5341d5465dbf0b35c64c54f200af8389a8b76aef 

git clone https://github.com/anniezfy/Torch_Affine_To_DOT.git
```

​    Again  install LLVM/MLIR according to https://mlir.llvm.org/getting_started/

2. Download the corresponding torch/torch front-ends

   Torch version: torch-2.1.0-cp311

   Torchmlir version: torch_mlir-20231019.996-cp311

​       Download link: https://github.com/llvm/torch-mlir/releases/tag/snapshot-20231019.996

```bash
python3 -m venv myenv

source myenv/bin/activate

wget https://github.com/llvm/torch-mlir/releases/tag/snapshot-20231019.996/torch-2.2.0.dev20231006+cpu-cp38-cp38-linux_x86_64.whl


wget https://github.com/llvm/torch-mlir/releases/tag/snapshot-20231019.996/torch_mlir-20231019.996-cp311-cp311-linux_x86_64.whl

pip3.11 torch-2.2.0.dev20231006+cpu-cp38-cp38-linux_x86_64.whl

pip3.11 torch_mlir-20231019.996-cp311-cp311-linux_x86_64.whl
```
# Dot format file illustration

Dot is known as a graph representation  language for  a clear and hierarchical  program flow structure description.

Besides, the Dot language provides syntax for defining (named and anonymous) graphs, nodes and edges, plus the ability to attach string-valued name-attribute pairs to graph components

For example:  two pairs of string-valued name-attribute are attached to node `a`

```
`digraph G {`
    `a [label="start", color="red"];`
    `b [label="end", color="green"];`
    `a -> b [label="path", style="dashed"];`
`}`
```

Dot is a language for describing the structure of graph of which could be rendered and visualized via Graphviz Tool and end 	up with generating a diagram.

​           [Graphivz Online  Link](
