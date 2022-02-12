function accessNested(object, keys) {
   var running= object;
   for (var index in keys) {
       var key = keys[index];
       if (key in running) {
           running= running[key];
       }
       else {
           return null;
       }
   }
   return running;
}


console.log(accessNested({ "1": { "2": { "3": "4" } } }, ['1', '2', '3']))
