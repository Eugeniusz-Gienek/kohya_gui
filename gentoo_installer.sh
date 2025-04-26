#!/bin/sh
cd /opt/kohyas_gui/
HOME=/opt/kohyas_gui/
STARTUP_CMD="python3.12"
rm -rf /opt/kohyas_gui/venv
python3.12 -m venv /opt/kohyas_gui/venv
source /opt/kohyas_gui/venv/bin/activate
pip install --upgrade pip
pip install setuptools
pip install tk
pip install easy_gui
./setup.sh
if [[ ! -f /opt/kohyas_gui/venv/lib/python3.12/site-packages/timm/models/maxxvit_patched_kohya_ss.py ]]; then
    sed "s/from dataclasses import dataclass, replace/from dataclasses import dataclass, replace, field/g" -i /opt/kohyas_gui/venv/lib/python3.12/site-packages/timm/models/maxxvit.py
    sed "s/conv_cfg: MaxxVitConvCfg = MaxxVitConvCfg()/conv_cfg: MaxxVitConvCfg = field(default_factory=MaxxVitConvCfg)/g" -i /opt/kohyas_gui/venv/lib/python3.12/site-packages/timm/models/maxxvit.py
    sed "s/transformer_cfg: MaxxVitTransformerCfg = MaxxVitTransformerCfg()/transformer_cfg: MaxxVitTransformerCfg = field(default_factory=MaxxVitTransformerCfg)/g" -i /opt/kohyas_gui/venv/lib/python3.12/site-packages/timm/models/maxxvit.py
    find ./ \( -type d -name .git -prune \) \( -type d -name .venv -prune \) -o -type f -print0 | xargs -0 sed -i 's/python3.10/python3.12/g'
    touch /opt/kohyas_gui/venv/lib/python3.12/site-packages/timm/models/maxxvit_patched_kohya_ss.py
fi
