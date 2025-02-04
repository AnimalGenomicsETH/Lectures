#!/usr/bin/env python

import argparse
from pathlib import PurePath
import subprocess
import xml.etree.ElementTree as ET
import tempfile

def parse_svg_layers(svg_file):
    """Parse the SVG file and extract layer names using Inkscape namespaces."""
    tree = ET.parse(svg_file)
    root = tree.getroot()
    
    # Define XML namespaces
    namespaces = {
        "svg": "http://www.w3.org/2000/svg",
        "inkscape": "http://www.inkscape.org/namespaces/inkscape"
    }
    
    # Extract layer names
    layers = {
        elem.get(f"{{{namespaces['inkscape']}}}label"): elem
        for elem in root.findall(".//svg:g[@inkscape:groupmode='layer']", namespaces)
    }
    return tree, layers

# Function to set visibility of layers
def set_layer_visibility(layers, visible_layers):
    for layer_name, layer in layers.items():
        if layer_name in visible_layers:
            layer.attrib.pop("style", None)  # Make layer visible
        else:
            layer.set("style", "display:none")  # Hide layer

def export_layer_group(svg_file, output_pdf, tree, available_layers, selected_layers):
    """Export a specific group of layers to a single PDF using Inkscape."""

    # Set layers' visibility
    set_layer_visibility(available_layers, selected_layers)

    with tempfile.NamedTemporaryFile(suffix=".svg", delete=False) as tmp_svg:
        tmp_svg_path = tmp_svg.name
        tree.write(tmp_svg_path)
        
        subprocess.run([
            "inkscape", tmp_svg_path,
            "--export-area-page",
            "--export-filename", output_pdf
        ], check=True)

def main():
    """Parse arguments and export layers based on user input."""
    parser = argparse.ArgumentParser(description="Export selected SVG layers as PDFs using Inkscape.")
    parser.add_argument("svg_file", help="Input SVG file")
    parser.add_argument(
        "layer_groups", 
        help="Layer groups to export (format: output.pdf:layer1,layer2,...)"
    )
    parser.add_argument("visible", help="visible on")
    parser.add_argument("width", help="width")

    args = parser.parse_args()
    args.svg_file += '.svg'

    pauses = args.visible.split(':')
    # Check available layers in the SVG
    tree, available_layers = parse_svg_layers(args.svg_file)
    
    latex_string = []
    for N, layers in enumerate(args.layer_groups.split(":")):
        layer_list = layers.split(",")
        output_pdf = 'svg-inkscape/' + PurePath(args.svg_file).stem + '-raw.pdf'
        export_layer_group(args.svg_file, output_pdf, tree, available_layers, layer_list)
        latex_string.append(rf'\only<{pauses[N]}>{{\includegraphics[width={args.width}\textwidth]{{{output_pdf}}}}}')

    print('%\n'.join(latex_string))

if __name__ == "__main__":
    main()
