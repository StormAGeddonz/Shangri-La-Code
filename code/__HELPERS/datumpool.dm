//This was made pretty explicity for atmospherics devices which could not delete their datums properly
//Make sure you go around and null out those references to the datum
//It was also pretty explicitly and shamelessly stolen from regular object pooling, thanks esword

//#define DEBUG_DATUM_POOL

#define MAINTAINING_DATUM_POOL_COUNT 500
var/global/list/masterdatumPool = new
var/global/list/pooledvariables = new

/*
 * @args : datum type, normal arguments
 * Example call: getFromPool(/datum/pipeline, args)
 */
