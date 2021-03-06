/*##############################################################################

    HPCC SYSTEMS software Copyright (C) 2012 HPCC Systems®.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
############################################################################## */

//Check a single child records can be treated as a blob

parentRecord :=
                RECORD
unsigned4           flags;
                    ifblock(self.flags & 2 <> 0)
unsigned8           id;
string20            address1;
string20            address2;
string20            address3;
unsigned2           numPeople;
string10            postcode;
                    end
                END;

parentDataset := DATASET('test',parentRecord,FLAT);

parentRecord copyAll(parentRecord l, parentRecord r) :=
TRANSFORM
    SELF := r;
END;

copied1 := ITERATE(parentDataset,copyAll(LEFT,RIGHT));

copied2 := ITERATE(copied1,copyAll(LEFT,RIGHT),LOCAL);

output(copied2,,'out.d00');
