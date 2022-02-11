# ---------------------------------- #
# --- Jyl's godot prop export v0 --- #
# ---------------------------------- #

# Exports each collection as
# "ProjectName_CollectionName.glb"
# Ignore collections with "ignore_"-prefix to collection name
# e.g. "ignore_area0_env"

import bpy
import os
from pathlib import Path

filepath = bpy.data.filepath
directory = os.path.dirname(filepath) + "/"
filename = Path(bpy.data.filepath).stem

print("\n")



for collection in bpy.data.collections:
    colname = collection.name
    if not collection.library: # ignore linked collections
        if not colname[0:7] == "ignore_":
            layer_collection = bpy.context.view_layer.layer_collection.children[colname]
            bpy.context.view_layer.active_layer_collection = layer_collection
            exportpath = directory + filename + "_" + colname + ".glb"
            
            bpy.ops.export_scene.gltf(
                filepath=exportpath,
                use_active_collection=True,
                export_apply=True
            )