
#ifndef OITarget
#error You must choose a target from this file to build Ohai correctly.
#endif

#define OITarget_OpenInkpot_HanlinV3 (1)
#define OITarget_AppKit (2147483647) // INT32_MAX

#if OITarget == OITarget_OpenInkpot_HanlinV3
#define OITargetFeatureEnlightenment 1
#endif
