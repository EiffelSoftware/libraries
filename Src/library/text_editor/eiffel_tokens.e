indexing

	description:

		"Token codes for Eiffel parsers"

	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1998, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class EIFFEL_TOKENS

feature -- Token codes

	E_CHARACTER: INTEGER is 258
	E_INTEGER: INTEGER is 259
	E_REAL: INTEGER is 260
	E_IDENTIFIER: INTEGER is 261
	E_STRING: INTEGER is 262
	E_BIT: INTEGER is 263
	E_BITTYPE: INTEGER is 264
	E_CHARERR: INTEGER is 265
	E_INTERR: INTEGER is 266
	E_REALERR: INTEGER is 267
	E_STRERR: INTEGER is 268
	E_UNKNOWN: INTEGER is 269
	E_NOMEMORY: INTEGER is 270
	E_BANGBANG: INTEGER is 271
	E_ARROW: INTEGER is 272
	E_DOTDOT: INTEGER is 273
	E_LARRAY: INTEGER is 274
	E_RARRAY: INTEGER is 275
	E_ASSIGN: INTEGER is 276
	E_REVERSE: INTEGER is 277
	E_ALIAS: INTEGER is 278
	E_ALL: INTEGER is 279
	E_AS: INTEGER is 280
	E_CHECK: INTEGER is 281
	E_CLASS: INTEGER is 282
	E_CREATION: INTEGER is 283
	E_DEBUG: INTEGER is 284
	E_DEFERRED: INTEGER is 285
	E_DO: INTEGER is 286
	E_ELSE: INTEGER is 287
	E_ELSEIF: INTEGER is 288
	E_END: INTEGER is 289
	E_ENSURE: INTEGER is 290
	E_EXPANDED: INTEGER is 291
	E_EXPORT: INTEGER is 292
	E_EXTERNAL: INTEGER is 293
	E_FALSE: INTEGER is 294
	E_FEATURE: INTEGER is 295
	E_FROM: INTEGER is 296
	E_FROZEN: INTEGER is 297
	E_IF: INTEGER is 298
	E_INDEXING: INTEGER is 299
	E_INFIX: INTEGER is 300
	E_INHERIT: INTEGER is 301
	E_INSPECT: INTEGER is 302
	E_INVARIANT: INTEGER is 303
	E_IS: INTEGER is 304
	E_LIKE: INTEGER is 305
	E_LOCAL: INTEGER is 306
	E_LOOP: INTEGER is 307
	E_OBSOLETE: INTEGER is 308
	E_ONCE: INTEGER is 309
	E_PREFIX: INTEGER is 310
	E_REDEFINE: INTEGER is 311
	E_RENAME: INTEGER is 312
	E_REQUIRE: INTEGER is 313
	E_RESCUE: INTEGER is 314
	E_RETRY: INTEGER is 315
	E_SELECT: INTEGER is 316
	E_SEPARATE: INTEGER is 317
	E_STRIP: INTEGER is 318
	E_THEN: INTEGER is 319
	E_TRUE: INTEGER is 320
	E_UNDEFINE: INTEGER is 321
	E_UNIQUE: INTEGER is 322
	E_UNTIL: INTEGER is 323
	E_VARIANT: INTEGER is 324
	E_WHEN: INTEGER is 325
	E_CURRENT: INTEGER is 326
	E_RESULT: INTEGER is 327
	E_STRPLUS: INTEGER is 328
	E_STRMINUS: INTEGER is 329
	E_STRSTAR: INTEGER is 330
	E_STRSLASH: INTEGER is 331
	E_STRDIV: INTEGER is 332
	E_STRMOD: INTEGER is 333
	E_STRPOWER: INTEGER is 334
	E_STRLT: INTEGER is 335
	E_STRLE: INTEGER is 336
	E_STRGT: INTEGER is 337
	E_STRGE: INTEGER is 338
	E_STRAND: INTEGER is 339
	E_STROR: INTEGER is 340
	E_STRXOR: INTEGER is 341
	E_STRANDTHEN: INTEGER is 342
	E_STRORELSE: INTEGER is 343
	E_STRIMPLIES: INTEGER is 344
	E_STRFREEOP: INTEGER is 345
	E_STRNOT: INTEGER is 346
	E_IMPLIES: INTEGER is 347
	E_OR: INTEGER is 348
	E_XOR: INTEGER is 349
	E_AND: INTEGER is 350
	E_NE: INTEGER is 351
	E_LE: INTEGER is 352
	E_GE: INTEGER is 353
	E_DIV: INTEGER is 354
	E_MOD: INTEGER is 355
	E_FREEOP: INTEGER is 356
	E_NOT: INTEGER is 357
	E_OLD: INTEGER is 358
	E_PRECURSOR: INTEGER is 359

	E_COMMENT: INTEGER is 360

	Eif_keyword: INTEGER is 1
	Eif_string: INTEGER is 2
	Eif_comment: INTEGER is 3
	Eif_identifier: INTEGER is 4
	Eif_number: INTEGER is 5
	Eif_default: INTEGER is 6
	

end -- class EIFFEL_TOKENS
