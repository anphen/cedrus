//
//  SinVoice Project
//  SinVoicePlayer.h
//
//  Created by gujicheng on 14-9-1.
//  Copyright (c) 2014 gujicheng. All rights reserved.
//

#ifndef __SinVoicePlayer_H__
#define __SinVoicePlayer_H__

#include "ESType.h"

#ifdef __cplusplus
extern "C" {
#endif

#define SINVOICE_PLAYER_TYPE1 1
#define SINVOICE_PLAYER_TYPE2 2

typedef struct __SinVoicePlayer SinVoicePlayer;

typedef struct __SinVoicePlayerCallback
{
    ESVoid (*onSinVoicePlayerStart)(ESVoid* cbParam);
    ESVoid (*onSinVoicePlayerStop)(ESVoid* cbParam);
} SinVoicePlayerCallback;

SinVoicePlayer* SinVoicePlayer_create(const ESChar* companyId, const ESChar* appId, SinVoicePlayerCallback* callback, ESVoid* cbParam, ESInt32 type);

ESBool SinVoicePlayer_play(SinVoicePlayer* pThis, const ESInt32* tokens, ESInt32 tokenCount);

ESVoid SinVoicePlayer_stop(SinVoicePlayer* pThis);

ESVoid SinVoicePlayer_destroy(SinVoicePlayer* pThis);

#ifdef __cplusplus
}
#endif

#endif /* __SinVoicePlayer_H__ */
