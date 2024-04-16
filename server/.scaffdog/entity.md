---
name: "entity"
root: "."
output: "."
ignore: []
questions:
  name: "Please enter entity name."
---

# `src/entity/entities/{{ kebab(inputs.name) }}.ts`

```typescript
export interface {{pascal(inputs.name)}} {

}
```

# `src/entity/db-models/{{ kebab(inputs.name) }}.ts`

```typescript
import { Schema, model } from "mongoose";
import { {{pascal(inputs.name)}} } from "../entities/{{kebab(inputs.name)}}";
const {{camel(inputs.name)}}Schema = new Schema<{{pascal(inputs.name)}}>({

});
export const {{pascal(inputs.name)}}Model = model<{{pascal(inputs.name)}}>("{{pascal(inputs.name)}}", {{camel(inputs.name)}}Schema );
```
