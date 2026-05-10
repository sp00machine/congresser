#!/bin/bash
# Run from the root of the congresser repo.
# Downloads 1860 Congress portraits from the Library of Congress.

set -e
mkdir -p public/photos/1860

python3 << 'PYEOF'
import json, re, subprocess, os, sys

MEMBERS = [
  ("stephen-douglas",     "https://tile.loc.gov/storage-services/service/pnp/ppmsca/53200/53278v.jpg"),
  ("william-seward",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/57800/57831v.jpg"),
  ("charles-sumner",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/54100/54138v.jpg"),
  ("jefferson-davis",     "https://tile.loc.gov/storage-services/service/pnp/ppmsca/23800/23852v.jpg"),
  ("andrew-johnson",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/05700/05704v.jpg"),
  ("henry-wilson",        "https://tile.loc.gov/storage-services/service/pnp/cwpbh/00600/00612v.jpg"),
  ("benjamin-wade",       "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26700/26730v.jpg"),
  ("hannibal-hamlin",     "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26500/26541v.jpg"),
  ("lyman-trumbull",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26700/26792v.jpg"),
  ("zachariah-chandler",  "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26800/26815v.jpg"),
  ("james-doolittle",     "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26800/26832v.jpg"),
  ("jacob-collamer",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26500/26555v.jpg"),
  ("james-a-bayard",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26600/26652v.jpg"),
  ("r-m-t-hunter",        "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26600/26664v.jpg"),
  ("john-c-breckinridge", "https://tile.loc.gov/storage-services/service/pnp/pga/04800/04882v.jpg"),
  ("thaddeus-stevens",    "https://tile.loc.gov/storage-services/service/pnp/cwpbh/00400/00460v.jpg"),
  ("william-pennington",  "https://tile.loc.gov/storage-services/service/pnp/pga/08500/08507v.jpg"),
  ("john-sherman",        "https://tile.loc.gov/storage-services/service/pnp/ppmsca/98000/98096v.jpg"),
  ("elihu-washburne",     "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26700/26793v.jpg"),
  ("galusha-grow",        "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26600/26639v.jpg"),
  ("clement-vallandigham","https://tile.loc.gov/storage-services/service/pnp/ppmsca/26700/26734v.jpg"),
  ("james-craig",         "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26800/26807v.jpg"),
  ("cadwallader-washburn","https://tile.loc.gov/storage-services/service/pnp/ppmsca/26800/26835v.jpg"),
  ("chauncey-knapp",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26500/26568v.jpg"),
  ("anson-burlingame",    "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26500/26565v.jpg"),
  ("philemon-bliss",      "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26700/26745v.jpg"),
  ("william-a-howard",    "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26800/26817v.jpg"),
  ("william-barksdale",   "https://tile.loc.gov/storage-services/service/pnp/ppmsca/26700/26720v.jpg"),
]

ok, fail = 0, 0
for slug, url in MEMBERS:
    dest = f"public/photos/1860/{slug}.jpg"
    print(f"  {slug}...", end=" ", flush=True)
    result = subprocess.run(
        ["curl", "-sL", "--max-time", "20", "-o", dest, url],
        capture_output=True
    )
    if result.returncode == 0 and os.path.getsize(dest) > 5000:
        print(f"✓ ({os.path.getsize(dest)//1024}k)")
        ok += 1
    else:
        print(f"✗ FAILED")
        fail += 1

print(f"\n{ok} downloaded, {fail} failed")
if fail == 0:
    print("All good! Run: git add public/photos/1860 && git commit -m 'Add 1860 portrait photos'")
PYEOF
