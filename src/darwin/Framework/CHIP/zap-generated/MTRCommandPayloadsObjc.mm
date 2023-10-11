/*
 *
 *    Copyright (c) 2022 Project CHIP Authors
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

#import "MTRCommandPayloadsObjc.h"
#import "MTRBackwardsCompatShims.h"
#import "MTRBaseDevice_Internal.h"
#import "MTRCommandPayloadExtensions_Internal.h"
#import "MTRCommandPayloads_Internal.h"
#import "MTRError_Internal.h"
#import "MTRLogging_Internal.h"
#import "NSDataSpanConversion.h"
#import "NSStringSpanConversion.h"

#include <app/data-model/Decode.h>
#include <lib/core/TLV.h>
#include <lib/support/CHIPListUtils.h>
#include <lib/support/CodeUtils.h>
#include <system/TLVPacketBufferBackingStore.h>

NS_ASSUME_NONNULL_BEGIN

@implementation MTRIdentifyClusterIdentifyParams
- (instancetype)init
{
    if (self = [super init]) {

        _identifyTime = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRIdentifyClusterIdentifyParams alloc] init];

    other.identifyTime = self.identifyTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: identifyTime:%@; >", NSStringFromClass([self class]), _identifyTime];
    return descriptionString;
}

@end

@implementation MTRIdentifyClusterIdentifyParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Identify::Commands::Identify::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.identifyTime = self.identifyTime.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRIdentifyClusterTriggerEffectParams
- (instancetype)init
{
    if (self = [super init]) {

        _effectIdentifier = @(0);

        _effectVariant = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRIdentifyClusterTriggerEffectParams alloc] init];

    other.effectIdentifier = self.effectIdentifier;
    other.effectVariant = self.effectVariant;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: effectIdentifier:%@; effectVariant:%@; >", NSStringFromClass([self class]), _effectIdentifier, _effectVariant];
    return descriptionString;
}

@end

@implementation MTRIdentifyClusterTriggerEffectParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Identify::Commands::TriggerEffect::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.effectIdentifier = static_cast<std::remove_reference_t<decltype(encodableStruct.effectIdentifier)>>(self.effectIdentifier.unsignedCharValue);
    }
    {
        encodableStruct.effectVariant = static_cast<std::remove_reference_t<decltype(encodableStruct.effectVariant)>>(self.effectVariant.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterAddGroupParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _groupName = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterAddGroupParams alloc] init];

    other.groupID = self.groupID;
    other.groupName = self.groupName;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; groupName:%@; >", NSStringFromClass([self class]), _groupID, _groupName];
    return descriptionString;
}

@end

@implementation MTRGroupsClusterAddGroupParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Groups::Commands::AddGroup::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.groupName = AsCharSpan(self.groupName);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterAddGroupParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRGroupsClusterAddGroupResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterAddGroupResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; >", NSStringFromClass([self class]), _status, _groupID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Groups::Commands::AddGroupResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGroupsClusterAddGroupResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Groups::Commands::AddGroupResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGroupsClusterAddGroupResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRGroupsClusterViewGroupParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterViewGroupParams alloc] init];

    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; >", NSStringFromClass([self class]), _groupID];
    return descriptionString;
}

@end

@implementation MTRGroupsClusterViewGroupParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Groups::Commands::ViewGroup::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterViewGroupParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRGroupsClusterViewGroupResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _groupName = @"";
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterViewGroupResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.groupName = self.groupName;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; groupName:%@; >", NSStringFromClass([self class]), _status, _groupID, _groupName];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Groups::Commands::ViewGroupResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGroupsClusterViewGroupResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Groups::Commands::ViewGroupResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.groupName = AsString(decodableStruct.groupName);
        if (self.groupName == nil) {
            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
            return err;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGroupsClusterViewGroupResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRGroupsClusterGetGroupMembershipParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupList = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterGetGroupMembershipParams alloc] init];

    other.groupList = self.groupList;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupList:%@; >", NSStringFromClass([self class]), _groupList];
    return descriptionString;
}

@end

@implementation MTRGroupsClusterGetGroupMembershipParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Groups::Commands::GetGroupMembership::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.groupList)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.groupList.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.groupList.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.groupList.count; ++i_0) {
                    if (![self.groupList[i_0] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (NSNumber *) self.groupList[i_0];
                    listHolder_0->mList[i_0] = element_0.unsignedShortValue;
                }
                encodableStruct.groupList = ListType_0(listHolder_0->mList, self.groupList.count);
            } else {
                encodableStruct.groupList = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterGetGroupMembershipResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _capacity = nil;

        _groupList = [NSArray array];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterGetGroupMembershipResponseParams alloc] init];

    other.capacity = self.capacity;
    other.groupList = self.groupList;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: capacity:%@; groupList:%@; >", NSStringFromClass([self class]), _capacity, _groupList];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Groups::Commands::GetGroupMembershipResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGroupsClusterGetGroupMembershipResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Groups::Commands::GetGroupMembershipResponse::DecodableType &)decodableStruct
{
    {
        if (decodableStruct.capacity.IsNull()) {
            self.capacity = nil;
        } else {
            self.capacity = [NSNumber numberWithUnsignedChar:decodableStruct.capacity.Value()];
        }
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.groupList.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithUnsignedShort:entry_0];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.groupList = array_0;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGroupsClusterRemoveGroupParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterRemoveGroupParams alloc] init];

    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; >", NSStringFromClass([self class]), _groupID];
    return descriptionString;
}

@end

@implementation MTRGroupsClusterRemoveGroupParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Groups::Commands::RemoveGroup::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterRemoveGroupParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRGroupsClusterRemoveGroupResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterRemoveGroupResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; >", NSStringFromClass([self class]), _status, _groupID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Groups::Commands::RemoveGroupResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGroupsClusterRemoveGroupResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Groups::Commands::RemoveGroupResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGroupsClusterRemoveGroupResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRGroupsClusterRemoveAllGroupsParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterRemoveAllGroupsParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRGroupsClusterRemoveAllGroupsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Groups::Commands::RemoveAllGroups::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterAddGroupIfIdentifyingParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _groupName = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupsClusterAddGroupIfIdentifyingParams alloc] init];

    other.groupID = self.groupID;
    other.groupName = self.groupName;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; groupName:%@; >", NSStringFromClass([self class]), _groupID, _groupName];
    return descriptionString;
}

@end

@implementation MTRGroupsClusterAddGroupIfIdentifyingParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Groups::Commands::AddGroupIfIdentifying::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.groupName = AsCharSpan(self.groupName);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupsClusterAddGroupIfIdentifyingParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRScenesClusterAddSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);

        _transitionTime = @(0);

        _sceneName = @"";

        _extensionFieldSets = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterAddSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.transitionTime = self.transitionTime;
    other.sceneName = self.sceneName;
    other.extensionFieldSets = self.extensionFieldSets;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; transitionTime:%@; sceneName:%@; extensionFieldSets:%@; >", NSStringFromClass([self class]), _groupID, _sceneID, _transitionTime, _sceneName, _extensionFieldSets];
    return descriptionString;
}

@end

@implementation MTRScenesClusterAddSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::AddScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.sceneName = AsCharSpan(self.sceneName);
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.extensionFieldSets)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.extensionFieldSets.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.extensionFieldSets.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.extensionFieldSets.count; ++i_0) {
                    if (![self.extensionFieldSets[i_0] isKindOfClass:[MTRScenesClusterExtensionFieldSet class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRScenesClusterExtensionFieldSet *) self.extensionFieldSets[i_0];
                    listHolder_0->mList[i_0].clusterID = element_0.clusterID.unsignedIntValue;
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].attributeValueList)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.attributeValueList.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.attributeValueList.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.attributeValueList.count; ++i_2) {
                                if (![element_0.attributeValueList[i_2] isKindOfClass:[MTRScenesClusterAttributeValuePair class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (MTRScenesClusterAttributeValuePair *) element_0.attributeValueList[i_2];
                                listHolder_2->mList[i_2].attributeID = element_2.attributeID.unsignedIntValue;
                                listHolder_2->mList[i_2].attributeValue = element_2.attributeValue.unsignedIntValue;
                            }
                            listHolder_0->mList[i_0].attributeValueList = ListType_2(listHolder_2->mList, element_0.attributeValueList.count);
                        } else {
                            listHolder_0->mList[i_0].attributeValueList = ListType_2();
                        }
                    }
                }
                encodableStruct.extensionFieldSets = ListType_0(listHolder_0->mList, self.extensionFieldSets.count);
            } else {
                encodableStruct.extensionFieldSets = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterAddSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterAddSceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterAddSceneResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _status, _groupID, _sceneID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::AddSceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterAddSceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::AddSceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.sceneID = [NSNumber numberWithUnsignedChar:decodableStruct.sceneID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterAddSceneResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterViewSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterViewSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _groupID, _sceneID];
    return descriptionString;
}

@end

@implementation MTRScenesClusterViewSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::ViewScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterViewSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterViewSceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _sceneID = @(0);

        _transitionTime = nil;

        _sceneName = nil;

        _extensionFieldSets = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterViewSceneResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.transitionTime = self.transitionTime;
    other.sceneName = self.sceneName;
    other.extensionFieldSets = self.extensionFieldSets;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; sceneID:%@; transitionTime:%@; sceneName:%@; extensionFieldSets:%@; >", NSStringFromClass([self class]), _status, _groupID, _sceneID, _transitionTime, _sceneName, _extensionFieldSets];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::ViewSceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterViewSceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::ViewSceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.sceneID = [NSNumber numberWithUnsignedChar:decodableStruct.sceneID];
    }
    {
        if (decodableStruct.transitionTime.HasValue()) {
            self.transitionTime = [NSNumber numberWithUnsignedShort:decodableStruct.transitionTime.Value()];
        } else {
            self.transitionTime = nil;
        }
    }
    {
        if (decodableStruct.sceneName.HasValue()) {
            self.sceneName = AsString(decodableStruct.sceneName.Value());
            if (self.sceneName == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.sceneName = nil;
        }
    }
    {
        if (decodableStruct.extensionFieldSets.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.extensionFieldSets.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    MTRScenesClusterExtensionFieldSet * newElement_1;
                    newElement_1 = [MTRScenesClusterExtensionFieldSet new];
                    newElement_1.clusterID = [NSNumber numberWithUnsignedInt:entry_1.clusterID];
                    { // Scope for our temporary variables
                        auto * array_3 = [NSMutableArray new];
                        auto iter_3 = entry_1.attributeValueList.begin();
                        while (iter_3.Next()) {
                            auto & entry_3 = iter_3.GetValue();
                            MTRScenesClusterAttributeValuePair * newElement_3;
                            newElement_3 = [MTRScenesClusterAttributeValuePair new];
                            newElement_3.attributeID = [NSNumber numberWithUnsignedInt:entry_3.attributeID];
                            newElement_3.attributeValue = [NSNumber numberWithUnsignedInt:entry_3.attributeValue];
                            [array_3 addObject:newElement_3];
                        }
                        CHIP_ERROR err = iter_3.GetStatus();
                        if (err != CHIP_NO_ERROR) {
                            return err;
                        }
                        newElement_1.attributeValueList = array_3;
                    }
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.extensionFieldSets = array_1;
            }
        } else {
            self.extensionFieldSets = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterViewSceneResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterRemoveSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterRemoveSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _groupID, _sceneID];
    return descriptionString;
}

@end

@implementation MTRScenesClusterRemoveSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::RemoveScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterRemoveSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterRemoveSceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterRemoveSceneResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _status, _groupID, _sceneID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::RemoveSceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterRemoveSceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::RemoveSceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.sceneID = [NSNumber numberWithUnsignedChar:decodableStruct.sceneID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterRemoveSceneResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterRemoveAllScenesParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterRemoveAllScenesParams alloc] init];

    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; >", NSStringFromClass([self class]), _groupID];
    return descriptionString;
}

@end

@implementation MTRScenesClusterRemoveAllScenesParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::RemoveAllScenes::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterRemoveAllScenesParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRScenesClusterRemoveAllScenesResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterRemoveAllScenesResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; >", NSStringFromClass([self class]), _status, _groupID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::RemoveAllScenesResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterRemoveAllScenesResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::RemoveAllScenesResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterRemoveAllScenesResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRScenesClusterStoreSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterStoreSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _groupID, _sceneID];
    return descriptionString;
}

@end

@implementation MTRScenesClusterStoreSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::StoreScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterStoreSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterStoreSceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterStoreSceneResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _status, _groupID, _sceneID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::StoreSceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterStoreSceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::StoreSceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.sceneID = [NSNumber numberWithUnsignedChar:decodableStruct.sceneID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterStoreSceneResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterRecallSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);

        _transitionTime = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterRecallSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.transitionTime = self.transitionTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; transitionTime:%@; >", NSStringFromClass([self class]), _groupID, _sceneID, _transitionTime];
    return descriptionString;
}

@end

@implementation MTRScenesClusterRecallSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::RecallScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }
    {
        if (self.transitionTime != nil) {
            auto & definedValue_0 = encodableStruct.transitionTime.Emplace();
            if (self.transitionTime == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                nonNullValue_1 = self.transitionTime.unsignedShortValue;
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterRecallSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterGetSceneMembershipParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterGetSceneMembershipParams alloc] init];

    other.groupID = self.groupID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; >", NSStringFromClass([self class]), _groupID];
    return descriptionString;
}

@end

@implementation MTRScenesClusterGetSceneMembershipParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::GetSceneMembership::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterGetSceneMembershipParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRScenesClusterGetSceneMembershipResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _capacity = nil;

        _groupID = @(0);

        _sceneList = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterGetSceneMembershipResponseParams alloc] init];

    other.status = self.status;
    other.capacity = self.capacity;
    other.groupID = self.groupID;
    other.sceneList = self.sceneList;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; capacity:%@; groupID:%@; sceneList:%@; >", NSStringFromClass([self class]), _status, _capacity, _groupID, _sceneList];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::GetSceneMembershipResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterGetSceneMembershipResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::GetSceneMembershipResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        if (decodableStruct.capacity.IsNull()) {
            self.capacity = nil;
        } else {
            self.capacity = [NSNumber numberWithUnsignedChar:decodableStruct.capacity.Value()];
        }
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        if (decodableStruct.sceneList.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.sceneList.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    NSNumber * newElement_1;
                    newElement_1 = [NSNumber numberWithUnsignedChar:entry_1];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.sceneList = array_1;
            }
        } else {
            self.sceneList = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterGetSceneMembershipResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}
@end
@implementation MTRScenesClusterEnhancedAddSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);

        _transitionTime = @(0);

        _sceneName = @"";

        _extensionFieldSets = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterEnhancedAddSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.transitionTime = self.transitionTime;
    other.sceneName = self.sceneName;
    other.extensionFieldSets = self.extensionFieldSets;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; transitionTime:%@; sceneName:%@; extensionFieldSets:%@; >", NSStringFromClass([self class]), _groupID, _sceneID, _transitionTime, _sceneName, _extensionFieldSets];
    return descriptionString;
}

@end

@implementation MTRScenesClusterEnhancedAddSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::EnhancedAddScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.sceneName = AsCharSpan(self.sceneName);
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.extensionFieldSets)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.extensionFieldSets.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.extensionFieldSets.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.extensionFieldSets.count; ++i_0) {
                    if (![self.extensionFieldSets[i_0] isKindOfClass:[MTRScenesClusterExtensionFieldSet class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRScenesClusterExtensionFieldSet *) self.extensionFieldSets[i_0];
                    listHolder_0->mList[i_0].clusterID = element_0.clusterID.unsignedIntValue;
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].attributeValueList)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.attributeValueList.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.attributeValueList.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.attributeValueList.count; ++i_2) {
                                if (![element_0.attributeValueList[i_2] isKindOfClass:[MTRScenesClusterAttributeValuePair class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (MTRScenesClusterAttributeValuePair *) element_0.attributeValueList[i_2];
                                listHolder_2->mList[i_2].attributeID = element_2.attributeID.unsignedIntValue;
                                listHolder_2->mList[i_2].attributeValue = element_2.attributeValue.unsignedIntValue;
                            }
                            listHolder_0->mList[i_0].attributeValueList = ListType_2(listHolder_2->mList, element_0.attributeValueList.count);
                        } else {
                            listHolder_0->mList[i_0].attributeValueList = ListType_2();
                        }
                    }
                }
                encodableStruct.extensionFieldSets = ListType_0(listHolder_0->mList, self.extensionFieldSets.count);
            } else {
                encodableStruct.extensionFieldSets = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterEnhancedAddSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterEnhancedAddSceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterEnhancedAddSceneResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _status, _groupID, _sceneID];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::EnhancedAddSceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterEnhancedAddSceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::EnhancedAddSceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.sceneID = [NSNumber numberWithUnsignedChar:decodableStruct.sceneID];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterEnhancedAddSceneResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterEnhancedViewSceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupID = @(0);

        _sceneID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterEnhancedViewSceneParams alloc] init];

    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupID:%@; sceneID:%@; >", NSStringFromClass([self class]), _groupID, _sceneID];
    return descriptionString;
}

@end

@implementation MTRScenesClusterEnhancedViewSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::EnhancedViewScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupID = self.groupID.unsignedShortValue;
    }
    {
        encodableStruct.sceneID = self.sceneID.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterEnhancedViewSceneParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterEnhancedViewSceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupID = @(0);

        _sceneID = @(0);

        _transitionTime = nil;

        _sceneName = nil;

        _extensionFieldSets = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterEnhancedViewSceneResponseParams alloc] init];

    other.status = self.status;
    other.groupID = self.groupID;
    other.sceneID = self.sceneID;
    other.transitionTime = self.transitionTime;
    other.sceneName = self.sceneName;
    other.extensionFieldSets = self.extensionFieldSets;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupID:%@; sceneID:%@; transitionTime:%@; sceneName:%@; extensionFieldSets:%@; >", NSStringFromClass([self class]), _status, _groupID, _sceneID, _transitionTime, _sceneName, _extensionFieldSets];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::EnhancedViewSceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterEnhancedViewSceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::EnhancedViewSceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupID = [NSNumber numberWithUnsignedShort:decodableStruct.groupID];
    }
    {
        self.sceneID = [NSNumber numberWithUnsignedChar:decodableStruct.sceneID];
    }
    {
        if (decodableStruct.transitionTime.HasValue()) {
            self.transitionTime = [NSNumber numberWithUnsignedShort:decodableStruct.transitionTime.Value()];
        } else {
            self.transitionTime = nil;
        }
    }
    {
        if (decodableStruct.sceneName.HasValue()) {
            self.sceneName = AsString(decodableStruct.sceneName.Value());
            if (self.sceneName == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.sceneName = nil;
        }
    }
    {
        if (decodableStruct.extensionFieldSets.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.extensionFieldSets.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    MTRScenesClusterExtensionFieldSet * newElement_1;
                    newElement_1 = [MTRScenesClusterExtensionFieldSet new];
                    newElement_1.clusterID = [NSNumber numberWithUnsignedInt:entry_1.clusterID];
                    { // Scope for our temporary variables
                        auto * array_3 = [NSMutableArray new];
                        auto iter_3 = entry_1.attributeValueList.begin();
                        while (iter_3.Next()) {
                            auto & entry_3 = iter_3.GetValue();
                            MTRScenesClusterAttributeValuePair * newElement_3;
                            newElement_3 = [MTRScenesClusterAttributeValuePair new];
                            newElement_3.attributeID = [NSNumber numberWithUnsignedInt:entry_3.attributeID];
                            newElement_3.attributeValue = [NSNumber numberWithUnsignedInt:entry_3.attributeValue];
                            [array_3 addObject:newElement_3];
                        }
                        CHIP_ERROR err = iter_3.GetStatus();
                        if (err != CHIP_NO_ERROR) {
                            return err;
                        }
                        newElement_1.attributeValueList = array_3;
                    }
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.extensionFieldSets = array_1;
            }
        } else {
            self.extensionFieldSets = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterEnhancedViewSceneResponseParams (Deprecated)

- (void)setGroupId:(NSNumber * _Nonnull)groupId
{
    self.groupID = groupId;
}

- (NSNumber * _Nonnull)groupId
{
    return self.groupID;
}

- (void)setSceneId:(NSNumber * _Nonnull)sceneId
{
    self.sceneID = sceneId;
}

- (NSNumber * _Nonnull)sceneId
{
    return self.sceneID;
}
@end
@implementation MTRScenesClusterCopySceneParams
- (instancetype)init
{
    if (self = [super init]) {

        _mode = @(0);

        _groupIdentifierFrom = @(0);

        _sceneIdentifierFrom = @(0);

        _groupIdentifierTo = @(0);

        _sceneIdentifierTo = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterCopySceneParams alloc] init];

    other.mode = self.mode;
    other.groupIdentifierFrom = self.groupIdentifierFrom;
    other.sceneIdentifierFrom = self.sceneIdentifierFrom;
    other.groupIdentifierTo = self.groupIdentifierTo;
    other.sceneIdentifierTo = self.sceneIdentifierTo;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: mode:%@; groupIdentifierFrom:%@; sceneIdentifierFrom:%@; groupIdentifierTo:%@; sceneIdentifierTo:%@; >", NSStringFromClass([self class]), _mode, _groupIdentifierFrom, _sceneIdentifierFrom, _groupIdentifierTo, _sceneIdentifierTo];
    return descriptionString;
}

@end

@implementation MTRScenesClusterCopySceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Scenes::Commands::CopyScene::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.mode = static_cast<std::remove_reference_t<decltype(encodableStruct.mode)>>(self.mode.unsignedCharValue);
    }
    {
        encodableStruct.groupIdentifierFrom = self.groupIdentifierFrom.unsignedShortValue;
    }
    {
        encodableStruct.sceneIdentifierFrom = self.sceneIdentifierFrom.unsignedCharValue;
    }
    {
        encodableStruct.groupIdentifierTo = self.groupIdentifierTo.unsignedShortValue;
    }
    {
        encodableStruct.sceneIdentifierTo = self.sceneIdentifierTo.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRScenesClusterCopySceneParams (Deprecated)

- (void)setGroupIdFrom:(NSNumber * _Nonnull)groupIdFrom
{
    self.groupIdentifierFrom = groupIdFrom;
}

- (NSNumber * _Nonnull)groupIdFrom
{
    return self.groupIdentifierFrom;
}

- (void)setSceneIdFrom:(NSNumber * _Nonnull)sceneIdFrom
{
    self.sceneIdentifierFrom = sceneIdFrom;
}

- (NSNumber * _Nonnull)sceneIdFrom
{
    return self.sceneIdentifierFrom;
}

- (void)setGroupIdTo:(NSNumber * _Nonnull)groupIdTo
{
    self.groupIdentifierTo = groupIdTo;
}

- (NSNumber * _Nonnull)groupIdTo
{
    return self.groupIdentifierTo;
}

- (void)setSceneIdTo:(NSNumber * _Nonnull)sceneIdTo
{
    self.sceneIdentifierTo = sceneIdTo;
}

- (NSNumber * _Nonnull)sceneIdTo
{
    return self.sceneIdentifierTo;
}
@end
@implementation MTRScenesClusterCopySceneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _groupIdentifierFrom = @(0);

        _sceneIdentifierFrom = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRScenesClusterCopySceneResponseParams alloc] init];

    other.status = self.status;
    other.groupIdentifierFrom = self.groupIdentifierFrom;
    other.sceneIdentifierFrom = self.sceneIdentifierFrom;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; groupIdentifierFrom:%@; sceneIdentifierFrom:%@; >", NSStringFromClass([self class]), _status, _groupIdentifierFrom, _sceneIdentifierFrom];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Scenes::Commands::CopySceneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRScenesClusterCopySceneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Scenes::Commands::CopySceneResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.groupIdentifierFrom = [NSNumber numberWithUnsignedShort:decodableStruct.groupIdentifierFrom];
    }
    {
        self.sceneIdentifierFrom = [NSNumber numberWithUnsignedChar:decodableStruct.sceneIdentifierFrom];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRScenesClusterCopySceneResponseParams (Deprecated)

- (void)setGroupIdFrom:(NSNumber * _Nonnull)groupIdFrom
{
    self.groupIdentifierFrom = groupIdFrom;
}

- (NSNumber * _Nonnull)groupIdFrom
{
    return self.groupIdentifierFrom;
}

- (void)setSceneIdFrom:(NSNumber * _Nonnull)sceneIdFrom
{
    self.sceneIdentifierFrom = sceneIdFrom;
}

- (NSNumber * _Nonnull)sceneIdFrom
{
    return self.sceneIdentifierFrom;
}
@end
@implementation MTROnOffClusterOffParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROnOffClusterOffParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROnOffClusterOffParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OnOff::Commands::Off::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROnOffClusterOnParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROnOffClusterOnParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROnOffClusterOnParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OnOff::Commands::On::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROnOffClusterToggleParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROnOffClusterToggleParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROnOffClusterToggleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OnOff::Commands::Toggle::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROnOffClusterOffWithEffectParams
- (instancetype)init
{
    if (self = [super init]) {

        _effectIdentifier = @(0);

        _effectVariant = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROnOffClusterOffWithEffectParams alloc] init];

    other.effectIdentifier = self.effectIdentifier;
    other.effectVariant = self.effectVariant;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: effectIdentifier:%@; effectVariant:%@; >", NSStringFromClass([self class]), _effectIdentifier, _effectVariant];
    return descriptionString;
}

@end

@implementation MTROnOffClusterOffWithEffectParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OnOff::Commands::OffWithEffect::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.effectIdentifier = static_cast<std::remove_reference_t<decltype(encodableStruct.effectIdentifier)>>(self.effectIdentifier.unsignedCharValue);
    }
    {
        encodableStruct.effectVariant = self.effectVariant.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROnOffClusterOffWithEffectParams (Deprecated)

- (void)setEffectId:(NSNumber * _Nonnull)effectId
{
    self.effectIdentifier = effectId;
}

- (NSNumber * _Nonnull)effectId
{
    return self.effectIdentifier;
}
@end
@implementation MTROnOffClusterOnWithRecallGlobalSceneParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROnOffClusterOnWithRecallGlobalSceneParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROnOffClusterOnWithRecallGlobalSceneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OnOff::Commands::OnWithRecallGlobalScene::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROnOffClusterOnWithTimedOffParams
- (instancetype)init
{
    if (self = [super init]) {

        _onOffControl = @(0);

        _onTime = @(0);

        _offWaitTime = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROnOffClusterOnWithTimedOffParams alloc] init];

    other.onOffControl = self.onOffControl;
    other.onTime = self.onTime;
    other.offWaitTime = self.offWaitTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: onOffControl:%@; onTime:%@; offWaitTime:%@; >", NSStringFromClass([self class]), _onOffControl, _onTime, _offWaitTime];
    return descriptionString;
}

@end

@implementation MTROnOffClusterOnWithTimedOffParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OnOff::Commands::OnWithTimedOff::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.onOffControl = static_cast<std::remove_reference_t<decltype(encodableStruct.onOffControl)>>(self.onOffControl.unsignedCharValue);
    }
    {
        encodableStruct.onTime = self.onTime.unsignedShortValue;
    }
    {
        encodableStruct.offWaitTime = self.offWaitTime.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterMoveToLevelParams
- (instancetype)init
{
    if (self = [super init]) {

        _level = @(0);

        _transitionTime = nil;

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterMoveToLevelParams alloc] init];

    other.level = self.level;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: level:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _level, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterMoveToLevelParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::MoveToLevel::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.level = self.level.unsignedCharValue;
    }
    {
        if (self.transitionTime == nil) {
            encodableStruct.transitionTime.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.transitionTime.SetNonNull();
            nonNullValue_0 = self.transitionTime.unsignedShortValue;
        }
    }
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterMoveParams
- (instancetype)init
{
    if (self = [super init]) {

        _moveMode = @(0);

        _rate = nil;

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterMoveParams alloc] init];

    other.moveMode = self.moveMode;
    other.rate = self.rate;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: moveMode:%@; rate:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _moveMode, _rate, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterMoveParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::Move::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.moveMode = static_cast<std::remove_reference_t<decltype(encodableStruct.moveMode)>>(self.moveMode.unsignedCharValue);
    }
    {
        if (self.rate == nil) {
            encodableStruct.rate.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.rate.SetNonNull();
            nonNullValue_0 = self.rate.unsignedCharValue;
        }
    }
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterStepParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepMode = @(0);

        _stepSize = @(0);

        _transitionTime = nil;

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterStepParams alloc] init];

    other.stepMode = self.stepMode;
    other.stepSize = self.stepSize;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepMode:%@; stepSize:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepMode, _stepSize, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterStepParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::Step::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepMode = static_cast<std::remove_reference_t<decltype(encodableStruct.stepMode)>>(self.stepMode.unsignedCharValue);
    }
    {
        encodableStruct.stepSize = self.stepSize.unsignedCharValue;
    }
    {
        if (self.transitionTime == nil) {
            encodableStruct.transitionTime.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.transitionTime.SetNonNull();
            nonNullValue_0 = self.transitionTime.unsignedShortValue;
        }
    }
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterStopParams
- (instancetype)init
{
    if (self = [super init]) {

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterStopParams alloc] init];

    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterStopParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::Stop::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterMoveToLevelWithOnOffParams
- (instancetype)init
{
    if (self = [super init]) {

        _level = @(0);

        _transitionTime = nil;

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterMoveToLevelWithOnOffParams alloc] init];

    other.level = self.level;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: level:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _level, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterMoveToLevelWithOnOffParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::MoveToLevelWithOnOff::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.level = self.level.unsignedCharValue;
    }
    {
        if (self.transitionTime == nil) {
            encodableStruct.transitionTime.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.transitionTime.SetNonNull();
            nonNullValue_0 = self.transitionTime.unsignedShortValue;
        }
    }
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterMoveWithOnOffParams
- (instancetype)init
{
    if (self = [super init]) {

        _moveMode = @(0);

        _rate = nil;

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterMoveWithOnOffParams alloc] init];

    other.moveMode = self.moveMode;
    other.rate = self.rate;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: moveMode:%@; rate:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _moveMode, _rate, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterMoveWithOnOffParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::MoveWithOnOff::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.moveMode = static_cast<std::remove_reference_t<decltype(encodableStruct.moveMode)>>(self.moveMode.unsignedCharValue);
    }
    {
        if (self.rate == nil) {
            encodableStruct.rate.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.rate.SetNonNull();
            nonNullValue_0 = self.rate.unsignedCharValue;
        }
    }
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterStepWithOnOffParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepMode = @(0);

        _stepSize = @(0);

        _transitionTime = nil;

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterStepWithOnOffParams alloc] init];

    other.stepMode = self.stepMode;
    other.stepSize = self.stepSize;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepMode:%@; stepSize:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepMode, _stepSize, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterStepWithOnOffParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::StepWithOnOff::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepMode = static_cast<std::remove_reference_t<decltype(encodableStruct.stepMode)>>(self.stepMode.unsignedCharValue);
    }
    {
        encodableStruct.stepSize = self.stepSize.unsignedCharValue;
    }
    {
        if (self.transitionTime == nil) {
            encodableStruct.transitionTime.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.transitionTime.SetNonNull();
            nonNullValue_0 = self.transitionTime.unsignedShortValue;
        }
    }
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterStopWithOnOffParams
- (instancetype)init
{
    if (self = [super init]) {

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterStopWithOnOffParams alloc] init];

    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterStopWithOnOffParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::StopWithOnOff::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.optionsMask = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsMask)>>(self.optionsMask.unsignedCharValue);
    }
    {
        encodableStruct.optionsOverride = static_cast<std::remove_reference_t<decltype(encodableStruct.optionsOverride)>>(self.optionsOverride.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLevelControlClusterMoveToClosestFrequencyParams
- (instancetype)init
{
    if (self = [super init]) {

        _frequency = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLevelControlClusterMoveToClosestFrequencyParams alloc] init];

    other.frequency = self.frequency;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: frequency:%@; >", NSStringFromClass([self class]), _frequency];
    return descriptionString;
}

@end

@implementation MTRLevelControlClusterMoveToClosestFrequencyParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LevelControl::Commands::MoveToClosestFrequency::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.frequency = self.frequency.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterInstantActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterInstantActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterInstantActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::InstantAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterInstantActionWithTransitionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;

        _transitionTime = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterInstantActionWithTransitionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.transitionTime = self.transitionTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; transitionTime:%@; >", NSStringFromClass([self class]), _actionID, _invokeID, _transitionTime];
    return descriptionString;
}

@end

@implementation MTRActionsClusterInstantActionWithTransitionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::InstantActionWithTransition::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterStartActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterStartActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterStartActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::StartAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterStartActionWithDurationParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;

        _duration = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterStartActionWithDurationParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.duration = self.duration;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; duration:%@; >", NSStringFromClass([self class]), _actionID, _invokeID, _duration];
    return descriptionString;
}

@end

@implementation MTRActionsClusterStartActionWithDurationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::StartActionWithDuration::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }
    {
        encodableStruct.duration = self.duration.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterStopActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterStopActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterStopActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::StopAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterPauseActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterPauseActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterPauseActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::PauseAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterPauseActionWithDurationParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;

        _duration = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterPauseActionWithDurationParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.duration = self.duration;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; duration:%@; >", NSStringFromClass([self class]), _actionID, _invokeID, _duration];
    return descriptionString;
}

@end

@implementation MTRActionsClusterPauseActionWithDurationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::PauseActionWithDuration::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }
    {
        encodableStruct.duration = self.duration.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterResumeActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterResumeActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterResumeActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::ResumeAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterEnableActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterEnableActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterEnableActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::EnableAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterEnableActionWithDurationParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;

        _duration = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterEnableActionWithDurationParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.duration = self.duration;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; duration:%@; >", NSStringFromClass([self class]), _actionID, _invokeID, _duration];
    return descriptionString;
}

@end

@implementation MTRActionsClusterEnableActionWithDurationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::EnableActionWithDuration::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }
    {
        encodableStruct.duration = self.duration.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterDisableActionParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterDisableActionParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; >", NSStringFromClass([self class]), _actionID, _invokeID];
    return descriptionString;
}

@end

@implementation MTRActionsClusterDisableActionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::DisableAction::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActionsClusterDisableActionWithDurationParams
- (instancetype)init
{
    if (self = [super init]) {

        _actionID = @(0);

        _invokeID = nil;

        _duration = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActionsClusterDisableActionWithDurationParams alloc] init];

    other.actionID = self.actionID;
    other.invokeID = self.invokeID;
    other.duration = self.duration;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: actionID:%@; invokeID:%@; duration:%@; >", NSStringFromClass([self class]), _actionID, _invokeID, _duration];
    return descriptionString;
}

@end

@implementation MTRActionsClusterDisableActionWithDurationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Actions::Commands::DisableActionWithDuration::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.actionID = self.actionID.unsignedShortValue;
    }
    {
        if (self.invokeID != nil) {
            auto & definedValue_0 = encodableStruct.invokeID.Emplace();
            definedValue_0 = self.invokeID.unsignedIntValue;
        }
    }
    {
        encodableStruct.duration = self.duration.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRBasicClusterMfgSpecificPingParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRBasicClusterMfgSpecificPingParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end
@implementation MTROTASoftwareUpdateProviderClusterQueryImageParams
- (instancetype)init
{
    if (self = [super init]) {

        _vendorID = @(0);

        _productID = @(0);

        _softwareVersion = @(0);

        _protocolsSupported = [NSArray array];

        _hardwareVersion = nil;

        _location = nil;

        _requestorCanConsent = nil;

        _metadataForProvider = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROTASoftwareUpdateProviderClusterQueryImageParams alloc] init];

    other.vendorID = self.vendorID;
    other.productID = self.productID;
    other.softwareVersion = self.softwareVersion;
    other.protocolsSupported = self.protocolsSupported;
    other.hardwareVersion = self.hardwareVersion;
    other.location = self.location;
    other.requestorCanConsent = self.requestorCanConsent;
    other.metadataForProvider = self.metadataForProvider;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: vendorID:%@; productID:%@; softwareVersion:%@; protocolsSupported:%@; hardwareVersion:%@; location:%@; requestorCanConsent:%@; metadataForProvider:%@; >", NSStringFromClass([self class]), _vendorID, _productID, _softwareVersion, _protocolsSupported, _hardwareVersion, _location, _requestorCanConsent, [_metadataForProvider base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTROTASoftwareUpdateProviderClusterQueryImageParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::QueryImage::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.vendorID = static_cast<std::remove_reference_t<decltype(encodableStruct.vendorID)>>(self.vendorID.unsignedShortValue);
    }
    {
        encodableStruct.productID = self.productID.unsignedShortValue;
    }
    {
        encodableStruct.softwareVersion = self.softwareVersion.unsignedIntValue;
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.protocolsSupported)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.protocolsSupported.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.protocolsSupported.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.protocolsSupported.count; ++i_0) {
                    if (![self.protocolsSupported[i_0] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (NSNumber *) self.protocolsSupported[i_0];
                    listHolder_0->mList[i_0] = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0])>>(element_0.unsignedCharValue);
                }
                encodableStruct.protocolsSupported = ListType_0(listHolder_0->mList, self.protocolsSupported.count);
            } else {
                encodableStruct.protocolsSupported = ListType_0();
            }
        }
    }
    {
        if (self.hardwareVersion != nil) {
            auto & definedValue_0 = encodableStruct.hardwareVersion.Emplace();
            definedValue_0 = self.hardwareVersion.unsignedShortValue;
        }
    }
    {
        if (self.location != nil) {
            auto & definedValue_0 = encodableStruct.location.Emplace();
            definedValue_0 = AsCharSpan(self.location);
        }
    }
    {
        if (self.requestorCanConsent != nil) {
            auto & definedValue_0 = encodableStruct.requestorCanConsent.Emplace();
            definedValue_0 = self.requestorCanConsent.boolValue;
        }
    }
    {
        if (self.metadataForProvider != nil) {
            auto & definedValue_0 = encodableStruct.metadataForProvider.Emplace();
            definedValue_0 = AsByteSpan(self.metadataForProvider);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROtaSoftwareUpdateProviderClusterQueryImageParams
@dynamic softwareVersion;
@dynamic protocolsSupported;
@dynamic hardwareVersion;
@dynamic location;
@dynamic requestorCanConsent;
@dynamic metadataForProvider;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end

@implementation MTROTASoftwareUpdateProviderClusterQueryImageParams (Deprecated)

- (void)setVendorId:(NSNumber * _Nonnull)vendorId
{
    self.vendorID = vendorId;
}

- (NSNumber * _Nonnull)vendorId
{
    return self.vendorID;
}

- (void)setProductId:(NSNumber * _Nonnull)productId
{
    self.productID = productId;
}

- (NSNumber * _Nonnull)productId
{
    return self.productID;
}
@end
@implementation MTROTASoftwareUpdateProviderClusterQueryImageResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _delayedActionTime = nil;

        _imageURI = nil;

        _softwareVersion = nil;

        _softwareVersionString = nil;

        _updateToken = nil;

        _userConsentNeeded = nil;

        _metadataForRequestor = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROTASoftwareUpdateProviderClusterQueryImageResponseParams alloc] init];

    other.status = self.status;
    other.delayedActionTime = self.delayedActionTime;
    other.imageURI = self.imageURI;
    other.softwareVersion = self.softwareVersion;
    other.softwareVersionString = self.softwareVersionString;
    other.updateToken = self.updateToken;
    other.userConsentNeeded = self.userConsentNeeded;
    other.metadataForRequestor = self.metadataForRequestor;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; delayedActionTime:%@; imageURI:%@; softwareVersion:%@; softwareVersionString:%@; updateToken:%@; userConsentNeeded:%@; metadataForRequestor:%@; >", NSStringFromClass([self class]), _status, _delayedActionTime, _imageURI, _softwareVersion, _softwareVersionString, [_updateToken base64EncodedStringWithOptions:0], _userConsentNeeded, [_metadataForRequestor base64EncodedStringWithOptions:0]];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::QueryImageResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROTASoftwareUpdateProviderClusterQueryImageResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::QueryImageResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.delayedActionTime.HasValue()) {
            self.delayedActionTime = [NSNumber numberWithUnsignedInt:decodableStruct.delayedActionTime.Value()];
        } else {
            self.delayedActionTime = nil;
        }
    }
    {
        if (decodableStruct.imageURI.HasValue()) {
            self.imageURI = AsString(decodableStruct.imageURI.Value());
            if (self.imageURI == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.imageURI = nil;
        }
    }
    {
        if (decodableStruct.softwareVersion.HasValue()) {
            self.softwareVersion = [NSNumber numberWithUnsignedInt:decodableStruct.softwareVersion.Value()];
        } else {
            self.softwareVersion = nil;
        }
    }
    {
        if (decodableStruct.softwareVersionString.HasValue()) {
            self.softwareVersionString = AsString(decodableStruct.softwareVersionString.Value());
            if (self.softwareVersionString == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.softwareVersionString = nil;
        }
    }
    {
        if (decodableStruct.updateToken.HasValue()) {
            self.updateToken = AsData(decodableStruct.updateToken.Value());
        } else {
            self.updateToken = nil;
        }
    }
    {
        if (decodableStruct.userConsentNeeded.HasValue()) {
            self.userConsentNeeded = [NSNumber numberWithBool:decodableStruct.userConsentNeeded.Value()];
        } else {
            self.userConsentNeeded = nil;
        }
    }
    {
        if (decodableStruct.metadataForRequestor.HasValue()) {
            self.metadataForRequestor = AsData(decodableStruct.metadataForRequestor.Value());
        } else {
            self.metadataForRequestor = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTROtaSoftwareUpdateProviderClusterQueryImageResponseParams
@dynamic status;
@dynamic delayedActionTime;
@dynamic imageURI;
@dynamic softwareVersion;
@dynamic softwareVersionString;
@dynamic updateToken;
@dynamic userConsentNeeded;
@dynamic metadataForRequestor;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTROTASoftwareUpdateProviderClusterApplyUpdateRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _updateToken = [NSData data];

        _newVersion = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROTASoftwareUpdateProviderClusterApplyUpdateRequestParams alloc] init];

    other.updateToken = self.updateToken;
    other.newVersion = self.newVersion;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: updateToken:%@; newVersion:%@; >", NSStringFromClass([self class]), [_updateToken base64EncodedStringWithOptions:0], _newVersion];
    return descriptionString;
}

@end

@implementation MTROTASoftwareUpdateProviderClusterApplyUpdateRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::ApplyUpdateRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.updateToken = AsByteSpan(self.updateToken);
    }
    {
        encodableStruct.newVersion = self.newVersion.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROtaSoftwareUpdateProviderClusterApplyUpdateRequestParams
@dynamic updateToken;
@dynamic newVersion;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTROTASoftwareUpdateProviderClusterApplyUpdateResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _action = @(0);

        _delayedActionTime = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROTASoftwareUpdateProviderClusterApplyUpdateResponseParams alloc] init];

    other.action = self.action;
    other.delayedActionTime = self.delayedActionTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: action:%@; delayedActionTime:%@; >", NSStringFromClass([self class]), _action, _delayedActionTime];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::ApplyUpdateResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROTASoftwareUpdateProviderClusterApplyUpdateResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::ApplyUpdateResponse::DecodableType &)decodableStruct
{
    {
        self.action = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.action)];
    }
    {
        self.delayedActionTime = [NSNumber numberWithUnsignedInt:decodableStruct.delayedActionTime];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTROtaSoftwareUpdateProviderClusterApplyUpdateResponseParams
@dynamic action;
@dynamic delayedActionTime;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTROTASoftwareUpdateProviderClusterNotifyUpdateAppliedParams
- (instancetype)init
{
    if (self = [super init]) {

        _updateToken = [NSData data];

        _softwareVersion = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROTASoftwareUpdateProviderClusterNotifyUpdateAppliedParams alloc] init];

    other.updateToken = self.updateToken;
    other.softwareVersion = self.softwareVersion;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: updateToken:%@; softwareVersion:%@; >", NSStringFromClass([self class]), [_updateToken base64EncodedStringWithOptions:0], _softwareVersion];
    return descriptionString;
}

@end

@implementation MTROTASoftwareUpdateProviderClusterNotifyUpdateAppliedParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OtaSoftwareUpdateProvider::Commands::NotifyUpdateApplied::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.updateToken = AsByteSpan(self.updateToken);
    }
    {
        encodableStruct.softwareVersion = self.softwareVersion.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROtaSoftwareUpdateProviderClusterNotifyUpdateAppliedParams
@dynamic updateToken;
@dynamic softwareVersion;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTROTASoftwareUpdateRequestorClusterAnnounceOTAProviderParams
- (instancetype)init
{
    if (self = [super init]) {

        _providerNodeID = @(0);

        _vendorID = @(0);

        _announcementReason = @(0);

        _metadataForNode = nil;

        _endpoint = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROTASoftwareUpdateRequestorClusterAnnounceOTAProviderParams alloc] init];

    other.providerNodeID = self.providerNodeID;
    other.vendorID = self.vendorID;
    other.announcementReason = self.announcementReason;
    other.metadataForNode = self.metadataForNode;
    other.endpoint = self.endpoint;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: providerNodeID:%@; vendorID:%@; announcementReason:%@; metadataForNode:%@; endpoint:%@; >", NSStringFromClass([self class]), _providerNodeID, _vendorID, _announcementReason, [_metadataForNode base64EncodedStringWithOptions:0], _endpoint];
    return descriptionString;
}

@end

@implementation MTROTASoftwareUpdateRequestorClusterAnnounceOTAProviderParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OtaSoftwareUpdateRequestor::Commands::AnnounceOTAProvider::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.providerNodeID = self.providerNodeID.unsignedLongLongValue;
    }
    {
        encodableStruct.vendorID = static_cast<std::remove_reference_t<decltype(encodableStruct.vendorID)>>(self.vendorID.unsignedShortValue);
    }
    {
        encodableStruct.announcementReason = static_cast<std::remove_reference_t<decltype(encodableStruct.announcementReason)>>(self.announcementReason.unsignedCharValue);
    }
    {
        if (self.metadataForNode != nil) {
            auto & definedValue_0 = encodableStruct.metadataForNode.Emplace();
            definedValue_0 = AsByteSpan(self.metadataForNode);
        }
    }
    {
        encodableStruct.endpoint = self.endpoint.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROtaSoftwareUpdateRequestorClusterAnnounceOtaProviderParams
@dynamic announcementReason;
@dynamic metadataForNode;
@dynamic endpoint;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end

@implementation MTROTASoftwareUpdateRequestorClusterAnnounceOTAProviderParams (Deprecated)

- (void)setProviderNodeId:(NSNumber * _Nonnull)providerNodeId
{
    self.providerNodeID = providerNodeId;
}

- (NSNumber * _Nonnull)providerNodeId
{
    return self.providerNodeID;
}

- (void)setVendorId:(NSNumber * _Nonnull)vendorId
{
    self.vendorID = vendorId;
}

- (NSNumber * _Nonnull)vendorId
{
    return self.vendorID;
}
@end
@implementation MTRGeneralCommissioningClusterArmFailSafeParams
- (instancetype)init
{
    if (self = [super init]) {

        _expiryLengthSeconds = @(0);

        _breadcrumb = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralCommissioningClusterArmFailSafeParams alloc] init];

    other.expiryLengthSeconds = self.expiryLengthSeconds;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: expiryLengthSeconds:%@; breadcrumb:%@; >", NSStringFromClass([self class]), _expiryLengthSeconds, _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRGeneralCommissioningClusterArmFailSafeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GeneralCommissioning::Commands::ArmFailSafe::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.expiryLengthSeconds = self.expiryLengthSeconds.unsignedShortValue;
    }
    {
        encodableStruct.breadcrumb = self.breadcrumb.unsignedLongLongValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGeneralCommissioningClusterArmFailSafeResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _errorCode = @(0);

        _debugText = @"";
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralCommissioningClusterArmFailSafeResponseParams alloc] init];

    other.errorCode = self.errorCode;
    other.debugText = self.debugText;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: errorCode:%@; debugText:%@; >", NSStringFromClass([self class]), _errorCode, _debugText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::GeneralCommissioning::Commands::ArmFailSafeResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGeneralCommissioningClusterArmFailSafeResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::GeneralCommissioning::Commands::ArmFailSafeResponse::DecodableType &)decodableStruct
{
    {
        self.errorCode = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.errorCode)];
    }
    {
        self.debugText = AsString(decodableStruct.debugText);
        if (self.debugText == nil) {
            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
            return err;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGeneralCommissioningClusterSetRegulatoryConfigParams
- (instancetype)init
{
    if (self = [super init]) {

        _newRegulatoryConfig = @(0);

        _countryCode = @"";

        _breadcrumb = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralCommissioningClusterSetRegulatoryConfigParams alloc] init];

    other.newRegulatoryConfig = self.newRegulatoryConfig;
    other.countryCode = self.countryCode;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newRegulatoryConfig:%@; countryCode:%@; breadcrumb:%@; >", NSStringFromClass([self class]), _newRegulatoryConfig, _countryCode, _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRGeneralCommissioningClusterSetRegulatoryConfigParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GeneralCommissioning::Commands::SetRegulatoryConfig::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newRegulatoryConfig = static_cast<std::remove_reference_t<decltype(encodableStruct.newRegulatoryConfig)>>(self.newRegulatoryConfig.unsignedCharValue);
    }
    {
        encodableStruct.countryCode = AsCharSpan(self.countryCode);
    }
    {
        encodableStruct.breadcrumb = self.breadcrumb.unsignedLongLongValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGeneralCommissioningClusterSetRegulatoryConfigResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _errorCode = @(0);

        _debugText = @"";
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralCommissioningClusterSetRegulatoryConfigResponseParams alloc] init];

    other.errorCode = self.errorCode;
    other.debugText = self.debugText;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: errorCode:%@; debugText:%@; >", NSStringFromClass([self class]), _errorCode, _debugText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::GeneralCommissioning::Commands::SetRegulatoryConfigResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGeneralCommissioningClusterSetRegulatoryConfigResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::GeneralCommissioning::Commands::SetRegulatoryConfigResponse::DecodableType &)decodableStruct
{
    {
        self.errorCode = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.errorCode)];
    }
    {
        self.debugText = AsString(decodableStruct.debugText);
        if (self.debugText == nil) {
            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
            return err;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGeneralCommissioningClusterCommissioningCompleteParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralCommissioningClusterCommissioningCompleteParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRGeneralCommissioningClusterCommissioningCompleteParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GeneralCommissioning::Commands::CommissioningComplete::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGeneralCommissioningClusterCommissioningCompleteResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _errorCode = @(0);

        _debugText = @"";
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralCommissioningClusterCommissioningCompleteResponseParams alloc] init];

    other.errorCode = self.errorCode;
    other.debugText = self.debugText;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: errorCode:%@; debugText:%@; >", NSStringFromClass([self class]), _errorCode, _debugText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::GeneralCommissioning::Commands::CommissioningCompleteResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGeneralCommissioningClusterCommissioningCompleteResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::GeneralCommissioning::Commands::CommissioningCompleteResponse::DecodableType &)decodableStruct
{
    {
        self.errorCode = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.errorCode)];
    }
    {
        self.debugText = AsString(decodableStruct.debugText);
        if (self.debugText == nil) {
            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
            return err;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRNetworkCommissioningClusterScanNetworksParams
- (instancetype)init
{
    if (self = [super init]) {

        _ssid = nil;

        _breadcrumb = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterScanNetworksParams alloc] init];

    other.ssid = self.ssid;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: ssid:%@; breadcrumb:%@; >", NSStringFromClass([self class]), [_ssid base64EncodedStringWithOptions:0], _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRNetworkCommissioningClusterScanNetworksParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::NetworkCommissioning::Commands::ScanNetworks::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.ssid != nil) {
            auto & definedValue_0 = encodableStruct.ssid.Emplace();
            if (self.ssid == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                nonNullValue_1 = AsByteSpan(self.ssid);
            }
        }
    }
    {
        if (self.breadcrumb != nil) {
            auto & definedValue_0 = encodableStruct.breadcrumb.Emplace();
            definedValue_0 = self.breadcrumb.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRNetworkCommissioningClusterScanNetworksResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _networkingStatus = @(0);

        _debugText = nil;

        _wiFiScanResults = nil;

        _threadScanResults = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterScanNetworksResponseParams alloc] init];

    other.networkingStatus = self.networkingStatus;
    other.debugText = self.debugText;
    other.wiFiScanResults = self.wiFiScanResults;
    other.threadScanResults = self.threadScanResults;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: networkingStatus:%@; debugText:%@; wiFiScanResults:%@; threadScanResults:%@; >", NSStringFromClass([self class]), _networkingStatus, _debugText, _wiFiScanResults, _threadScanResults];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::NetworkCommissioning::Commands::ScanNetworksResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRNetworkCommissioningClusterScanNetworksResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::NetworkCommissioning::Commands::ScanNetworksResponse::DecodableType &)decodableStruct
{
    {
        self.networkingStatus = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.networkingStatus)];
    }
    {
        if (decodableStruct.debugText.HasValue()) {
            self.debugText = AsString(decodableStruct.debugText.Value());
            if (self.debugText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.debugText = nil;
        }
    }
    {
        if (decodableStruct.wiFiScanResults.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.wiFiScanResults.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    MTRNetworkCommissioningClusterWiFiInterfaceScanResultStruct * newElement_1;
                    newElement_1 = [MTRNetworkCommissioningClusterWiFiInterfaceScanResultStruct new];
                    newElement_1.security = [NSNumber numberWithUnsignedChar:entry_1.security.Raw()];
                    newElement_1.ssid = AsData(entry_1.ssid);
                    newElement_1.bssid = AsData(entry_1.bssid);
                    newElement_1.channel = [NSNumber numberWithUnsignedShort:entry_1.channel];
                    newElement_1.wiFiBand = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_1.wiFiBand)];
                    newElement_1.rssi = [NSNumber numberWithChar:entry_1.rssi];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.wiFiScanResults = array_1;
            }
        } else {
            self.wiFiScanResults = nil;
        }
    }
    {
        if (decodableStruct.threadScanResults.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.threadScanResults.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    MTRNetworkCommissioningClusterThreadInterfaceScanResultStruct * newElement_1;
                    newElement_1 = [MTRNetworkCommissioningClusterThreadInterfaceScanResultStruct new];
                    newElement_1.panId = [NSNumber numberWithUnsignedShort:entry_1.panId];
                    newElement_1.extendedPanId = [NSNumber numberWithUnsignedLongLong:entry_1.extendedPanId];
                    newElement_1.networkName = AsString(entry_1.networkName);
                    if (newElement_1.networkName == nil) {
                        CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                        return err;
                    }
                    newElement_1.channel = [NSNumber numberWithUnsignedShort:entry_1.channel];
                    newElement_1.version = [NSNumber numberWithUnsignedChar:entry_1.version];
                    newElement_1.extendedAddress = AsData(entry_1.extendedAddress);
                    newElement_1.rssi = [NSNumber numberWithChar:entry_1.rssi];
                    newElement_1.lqi = [NSNumber numberWithUnsignedChar:entry_1.lqi];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.threadScanResults = array_1;
            }
        } else {
            self.threadScanResults = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRNetworkCommissioningClusterAddOrUpdateWiFiNetworkParams
- (instancetype)init
{
    if (self = [super init]) {

        _ssid = [NSData data];

        _credentials = [NSData data];

        _breadcrumb = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterAddOrUpdateWiFiNetworkParams alloc] init];

    other.ssid = self.ssid;
    other.credentials = self.credentials;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: ssid:%@; credentials:%@; breadcrumb:%@; >", NSStringFromClass([self class]), [_ssid base64EncodedStringWithOptions:0], [_credentials base64EncodedStringWithOptions:0], _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRNetworkCommissioningClusterAddOrUpdateWiFiNetworkParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::NetworkCommissioning::Commands::AddOrUpdateWiFiNetwork::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.ssid = AsByteSpan(self.ssid);
    }
    {
        encodableStruct.credentials = AsByteSpan(self.credentials);
    }
    {
        if (self.breadcrumb != nil) {
            auto & definedValue_0 = encodableStruct.breadcrumb.Emplace();
            definedValue_0 = self.breadcrumb.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRNetworkCommissioningClusterAddOrUpdateThreadNetworkParams
- (instancetype)init
{
    if (self = [super init]) {

        _operationalDataset = [NSData data];

        _breadcrumb = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterAddOrUpdateThreadNetworkParams alloc] init];

    other.operationalDataset = self.operationalDataset;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: operationalDataset:%@; breadcrumb:%@; >", NSStringFromClass([self class]), [_operationalDataset base64EncodedStringWithOptions:0], _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRNetworkCommissioningClusterAddOrUpdateThreadNetworkParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::NetworkCommissioning::Commands::AddOrUpdateThreadNetwork::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.operationalDataset = AsByteSpan(self.operationalDataset);
    }
    {
        if (self.breadcrumb != nil) {
            auto & definedValue_0 = encodableStruct.breadcrumb.Emplace();
            definedValue_0 = self.breadcrumb.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRNetworkCommissioningClusterRemoveNetworkParams
- (instancetype)init
{
    if (self = [super init]) {

        _networkID = [NSData data];

        _breadcrumb = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterRemoveNetworkParams alloc] init];

    other.networkID = self.networkID;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: networkID:%@; breadcrumb:%@; >", NSStringFromClass([self class]), [_networkID base64EncodedStringWithOptions:0], _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRNetworkCommissioningClusterRemoveNetworkParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::NetworkCommissioning::Commands::RemoveNetwork::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.networkID = AsByteSpan(self.networkID);
    }
    {
        if (self.breadcrumb != nil) {
            auto & definedValue_0 = encodableStruct.breadcrumb.Emplace();
            definedValue_0 = self.breadcrumb.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRNetworkCommissioningClusterNetworkConfigResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _networkingStatus = @(0);

        _debugText = nil;

        _networkIndex = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterNetworkConfigResponseParams alloc] init];

    other.networkingStatus = self.networkingStatus;
    other.debugText = self.debugText;
    other.networkIndex = self.networkIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: networkingStatus:%@; debugText:%@; networkIndex:%@; >", NSStringFromClass([self class]), _networkingStatus, _debugText, _networkIndex];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::NetworkCommissioning::Commands::NetworkConfigResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRNetworkCommissioningClusterNetworkConfigResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::NetworkCommissioning::Commands::NetworkConfigResponse::DecodableType &)decodableStruct
{
    {
        self.networkingStatus = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.networkingStatus)];
    }
    {
        if (decodableStruct.debugText.HasValue()) {
            self.debugText = AsString(decodableStruct.debugText.Value());
            if (self.debugText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.debugText = nil;
        }
    }
    {
        if (decodableStruct.networkIndex.HasValue()) {
            self.networkIndex = [NSNumber numberWithUnsignedChar:decodableStruct.networkIndex.Value()];
        } else {
            self.networkIndex = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRNetworkCommissioningClusterConnectNetworkParams
- (instancetype)init
{
    if (self = [super init]) {

        _networkID = [NSData data];

        _breadcrumb = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterConnectNetworkParams alloc] init];

    other.networkID = self.networkID;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: networkID:%@; breadcrumb:%@; >", NSStringFromClass([self class]), [_networkID base64EncodedStringWithOptions:0], _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRNetworkCommissioningClusterConnectNetworkParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::NetworkCommissioning::Commands::ConnectNetwork::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.networkID = AsByteSpan(self.networkID);
    }
    {
        if (self.breadcrumb != nil) {
            auto & definedValue_0 = encodableStruct.breadcrumb.Emplace();
            definedValue_0 = self.breadcrumb.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRNetworkCommissioningClusterConnectNetworkResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _networkingStatus = @(0);

        _debugText = nil;

        _errorValue = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterConnectNetworkResponseParams alloc] init];

    other.networkingStatus = self.networkingStatus;
    other.debugText = self.debugText;
    other.errorValue = self.errorValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: networkingStatus:%@; debugText:%@; errorValue:%@; >", NSStringFromClass([self class]), _networkingStatus, _debugText, _errorValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::NetworkCommissioning::Commands::ConnectNetworkResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRNetworkCommissioningClusterConnectNetworkResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::NetworkCommissioning::Commands::ConnectNetworkResponse::DecodableType &)decodableStruct
{
    {
        self.networkingStatus = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.networkingStatus)];
    }
    {
        if (decodableStruct.debugText.HasValue()) {
            self.debugText = AsString(decodableStruct.debugText.Value());
            if (self.debugText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.debugText = nil;
        }
    }
    {
        if (decodableStruct.errorValue.IsNull()) {
            self.errorValue = nil;
        } else {
            self.errorValue = [NSNumber numberWithInt:decodableStruct.errorValue.Value()];
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRNetworkCommissioningClusterReorderNetworkParams
- (instancetype)init
{
    if (self = [super init]) {

        _networkID = [NSData data];

        _networkIndex = @(0);

        _breadcrumb = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRNetworkCommissioningClusterReorderNetworkParams alloc] init];

    other.networkID = self.networkID;
    other.networkIndex = self.networkIndex;
    other.breadcrumb = self.breadcrumb;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: networkID:%@; networkIndex:%@; breadcrumb:%@; >", NSStringFromClass([self class]), [_networkID base64EncodedStringWithOptions:0], _networkIndex, _breadcrumb];
    return descriptionString;
}

@end

@implementation MTRNetworkCommissioningClusterReorderNetworkParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::NetworkCommissioning::Commands::ReorderNetwork::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.networkID = AsByteSpan(self.networkID);
    }
    {
        encodableStruct.networkIndex = self.networkIndex.unsignedCharValue;
    }
    {
        if (self.breadcrumb != nil) {
            auto & definedValue_0 = encodableStruct.breadcrumb.Emplace();
            definedValue_0 = self.breadcrumb.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDiagnosticLogsClusterRetrieveLogsRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _intent = @(0);

        _requestedProtocol = @(0);

        _transferFileDesignator = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDiagnosticLogsClusterRetrieveLogsRequestParams alloc] init];

    other.intent = self.intent;
    other.requestedProtocol = self.requestedProtocol;
    other.transferFileDesignator = self.transferFileDesignator;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: intent:%@; requestedProtocol:%@; transferFileDesignator:%@; >", NSStringFromClass([self class]), _intent, _requestedProtocol, _transferFileDesignator];
    return descriptionString;
}

@end

@implementation MTRDiagnosticLogsClusterRetrieveLogsRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DiagnosticLogs::Commands::RetrieveLogsRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.intent = static_cast<std::remove_reference_t<decltype(encodableStruct.intent)>>(self.intent.unsignedCharValue);
    }
    {
        encodableStruct.requestedProtocol = static_cast<std::remove_reference_t<decltype(encodableStruct.requestedProtocol)>>(self.requestedProtocol.unsignedCharValue);
    }
    {
        if (self.transferFileDesignator != nil) {
            auto & definedValue_0 = encodableStruct.transferFileDesignator.Emplace();
            definedValue_0 = AsCharSpan(self.transferFileDesignator);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDiagnosticLogsClusterRetrieveLogsResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _logContent = [NSData data];

        _utcTimeStamp = nil;

        _timeSinceBoot = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDiagnosticLogsClusterRetrieveLogsResponseParams alloc] init];

    other.status = self.status;
    other.logContent = self.logContent;
    other.utcTimeStamp = self.utcTimeStamp;
    other.timeSinceBoot = self.timeSinceBoot;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; logContent:%@; utcTimeStamp:%@; timeSinceBoot:%@; >", NSStringFromClass([self class]), _status, [_logContent base64EncodedStringWithOptions:0], _utcTimeStamp, _timeSinceBoot];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DiagnosticLogs::Commands::RetrieveLogsResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDiagnosticLogsClusterRetrieveLogsResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DiagnosticLogs::Commands::RetrieveLogsResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        self.logContent = AsData(decodableStruct.logContent);
    }
    {
        if (decodableStruct.UTCTimeStamp.HasValue()) {
            self.utcTimeStamp = [NSNumber numberWithUnsignedLongLong:decodableStruct.UTCTimeStamp.Value()];
        } else {
            self.utcTimeStamp = nil;
        }
    }
    {
        if (decodableStruct.timeSinceBoot.HasValue()) {
            self.timeSinceBoot = [NSNumber numberWithUnsignedLongLong:decodableStruct.timeSinceBoot.Value()];
        } else {
            self.timeSinceBoot = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDiagnosticLogsClusterRetrieveLogsResponseParams (Deprecated)

- (void)setContent:(NSData * _Nonnull)content
{
    self.logContent = content;
}

- (NSData * _Nonnull)content
{
    return self.logContent;
}

- (void)setTimeStamp:(NSNumber * _Nullable)timeStamp
{
    self.utcTimeStamp = timeStamp;
}

- (NSNumber * _Nullable)timeStamp
{
    return self.utcTimeStamp;
}
@end
@implementation MTRGeneralDiagnosticsClusterTestEventTriggerParams
- (instancetype)init
{
    if (self = [super init]) {

        _enableKey = [NSData data];

        _eventTrigger = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGeneralDiagnosticsClusterTestEventTriggerParams alloc] init];

    other.enableKey = self.enableKey;
    other.eventTrigger = self.eventTrigger;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: enableKey:%@; eventTrigger:%@; >", NSStringFromClass([self class]), [_enableKey base64EncodedStringWithOptions:0], _eventTrigger];
    return descriptionString;
}

@end

@implementation MTRGeneralDiagnosticsClusterTestEventTriggerParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GeneralDiagnostics::Commands::TestEventTrigger::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.enableKey = AsByteSpan(self.enableKey);
    }
    {
        encodableStruct.eventTrigger = self.eventTrigger.unsignedLongLongValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRSoftwareDiagnosticsClusterResetWatermarksParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRSoftwareDiagnosticsClusterResetWatermarksParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRSoftwareDiagnosticsClusterResetWatermarksParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::SoftwareDiagnostics::Commands::ResetWatermarks::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRThreadNetworkDiagnosticsClusterResetCountsParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRThreadNetworkDiagnosticsClusterResetCountsParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRThreadNetworkDiagnosticsClusterResetCountsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ThreadNetworkDiagnostics::Commands::ResetCounts::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWiFiNetworkDiagnosticsClusterResetCountsParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWiFiNetworkDiagnosticsClusterResetCountsParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRWiFiNetworkDiagnosticsClusterResetCountsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WiFiNetworkDiagnostics::Commands::ResetCounts::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTREthernetNetworkDiagnosticsClusterResetCountsParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTREthernetNetworkDiagnosticsClusterResetCountsParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTREthernetNetworkDiagnosticsClusterResetCountsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::EthernetNetworkDiagnostics::Commands::ResetCounts::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTimeSynchronizationClusterSetUTCTimeParams
- (instancetype)init
{
    if (self = [super init]) {

        _utcTime = @(0);

        _granularity = @(0);

        _timeSource = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTimeSynchronizationClusterSetUTCTimeParams alloc] init];

    other.utcTime = self.utcTime;
    other.granularity = self.granularity;
    other.timeSource = self.timeSource;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: utcTime:%@; granularity:%@; timeSource:%@; >", NSStringFromClass([self class]), _utcTime, _granularity, _timeSource];
    return descriptionString;
}

@end

@implementation MTRTimeSynchronizationClusterSetUTCTimeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TimeSynchronization::Commands::SetUTCTime::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.UTCTime = self.utcTime.unsignedLongLongValue;
    }
    {
        encodableStruct.granularity = static_cast<std::remove_reference_t<decltype(encodableStruct.granularity)>>(self.granularity.unsignedCharValue);
    }
    {
        if (self.timeSource != nil) {
            auto & definedValue_0 = encodableStruct.timeSource.Emplace();
            definedValue_0 = static_cast<std::remove_reference_t<decltype(definedValue_0)>>(self.timeSource.unsignedCharValue);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTimeSynchronizationClusterSetUtcTimeParams
@dynamic utcTime;
@dynamic granularity;
@dynamic timeSource;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRTimeSynchronizationClusterSetTrustedTimeSourceParams
- (instancetype)init
{
    if (self = [super init]) {

        _trustedTimeSource = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTimeSynchronizationClusterSetTrustedTimeSourceParams alloc] init];

    other.trustedTimeSource = self.trustedTimeSource;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: trustedTimeSource:%@; >", NSStringFromClass([self class]), _trustedTimeSource];
    return descriptionString;
}

@end

@implementation MTRTimeSynchronizationClusterSetTrustedTimeSourceParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TimeSynchronization::Commands::SetTrustedTimeSource::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.trustedTimeSource == nil) {
            encodableStruct.trustedTimeSource.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.trustedTimeSource.SetNonNull();
            nonNullValue_0.nodeID = self.trustedTimeSource.nodeID.unsignedLongLongValue;
            nonNullValue_0.endpoint = self.trustedTimeSource.endpoint.unsignedShortValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTimeSynchronizationClusterSetTimeZoneParams
- (instancetype)init
{
    if (self = [super init]) {

        _timeZone = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTimeSynchronizationClusterSetTimeZoneParams alloc] init];

    other.timeZone = self.timeZone;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: timeZone:%@; >", NSStringFromClass([self class]), _timeZone];
    return descriptionString;
}

@end

@implementation MTRTimeSynchronizationClusterSetTimeZoneParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TimeSynchronization::Commands::SetTimeZone::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.timeZone)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.timeZone.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.timeZone.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.timeZone.count; ++i_0) {
                    if (![self.timeZone[i_0] isKindOfClass:[MTRTimeSynchronizationClusterTimeZoneStruct class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRTimeSynchronizationClusterTimeZoneStruct *) self.timeZone[i_0];
                    listHolder_0->mList[i_0].offset = element_0.offset.intValue;
                    listHolder_0->mList[i_0].validAt = element_0.validAt.unsignedLongLongValue;
                    if (element_0.name != nil) {
                        auto & definedValue_2 = listHolder_0->mList[i_0].name.Emplace();
                        definedValue_2 = AsCharSpan(element_0.name);
                    }
                }
                encodableStruct.timeZone = ListType_0(listHolder_0->mList, self.timeZone.count);
            } else {
                encodableStruct.timeZone = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTimeSynchronizationClusterSetTimeZoneResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _dstOffsetRequired = @(0);
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTimeSynchronizationClusterSetTimeZoneResponseParams alloc] init];

    other.dstOffsetRequired = self.dstOffsetRequired;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: dstOffsetRequired:%@; >", NSStringFromClass([self class]), _dstOffsetRequired];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::TimeSynchronization::Commands::SetTimeZoneResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRTimeSynchronizationClusterSetTimeZoneResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::TimeSynchronization::Commands::SetTimeZoneResponse::DecodableType &)decodableStruct
{
    {
        self.dstOffsetRequired = [NSNumber numberWithBool:decodableStruct.DSTOffsetRequired];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTimeSynchronizationClusterSetDSTOffsetParams
- (instancetype)init
{
    if (self = [super init]) {

        _dstOffset = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTimeSynchronizationClusterSetDSTOffsetParams alloc] init];

    other.dstOffset = self.dstOffset;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: dstOffset:%@; >", NSStringFromClass([self class]), _dstOffset];
    return descriptionString;
}

@end

@implementation MTRTimeSynchronizationClusterSetDSTOffsetParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TimeSynchronization::Commands::SetDSTOffset::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.DSTOffset)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.dstOffset.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.dstOffset.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.dstOffset.count; ++i_0) {
                    if (![self.dstOffset[i_0] isKindOfClass:[MTRTimeSynchronizationClusterDSTOffsetStruct class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRTimeSynchronizationClusterDSTOffsetStruct *) self.dstOffset[i_0];
                    listHolder_0->mList[i_0].offset = element_0.offset.intValue;
                    listHolder_0->mList[i_0].validStarting = element_0.validStarting.unsignedLongLongValue;
                    if (element_0.validUntil == nil) {
                        listHolder_0->mList[i_0].validUntil.SetNull();
                    } else {
                        auto & nonNullValue_2 = listHolder_0->mList[i_0].validUntil.SetNonNull();
                        nonNullValue_2 = element_0.validUntil.unsignedLongLongValue;
                    }
                }
                encodableStruct.DSTOffset = ListType_0(listHolder_0->mList, self.dstOffset.count);
            } else {
                encodableStruct.DSTOffset = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTimeSynchronizationClusterSetDefaultNTPParams
- (instancetype)init
{
    if (self = [super init]) {

        _defaultNTP = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTimeSynchronizationClusterSetDefaultNTPParams alloc] init];

    other.defaultNTP = self.defaultNTP;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: defaultNTP:%@; >", NSStringFromClass([self class]), _defaultNTP];
    return descriptionString;
}

@end

@implementation MTRTimeSynchronizationClusterSetDefaultNTPParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TimeSynchronization::Commands::SetDefaultNTP::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.defaultNTP == nil) {
            encodableStruct.defaultNTP.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.defaultNTP.SetNonNull();
            nonNullValue_0 = AsCharSpan(self.defaultNTP);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRAdministratorCommissioningClusterOpenCommissioningWindowParams
- (instancetype)init
{
    if (self = [super init]) {

        _commissioningTimeout = @(0);

        _pakePasscodeVerifier = [NSData data];

        _discriminator = @(0);

        _iterations = @(0);

        _salt = [NSData data];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAdministratorCommissioningClusterOpenCommissioningWindowParams alloc] init];

    other.commissioningTimeout = self.commissioningTimeout;
    other.pakePasscodeVerifier = self.pakePasscodeVerifier;
    other.discriminator = self.discriminator;
    other.iterations = self.iterations;
    other.salt = self.salt;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: commissioningTimeout:%@; pakePasscodeVerifier:%@; discriminator:%@; iterations:%@; salt:%@; >", NSStringFromClass([self class]), _commissioningTimeout, [_pakePasscodeVerifier base64EncodedStringWithOptions:0], _discriminator, _iterations, [_salt base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRAdministratorCommissioningClusterOpenCommissioningWindowParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AdministratorCommissioning::Commands::OpenCommissioningWindow::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.commissioningTimeout = self.commissioningTimeout.unsignedShortValue;
    }
    {
        encodableStruct.PAKEPasscodeVerifier = AsByteSpan(self.pakePasscodeVerifier);
    }
    {
        encodableStruct.discriminator = self.discriminator.unsignedShortValue;
    }
    {
        encodableStruct.iterations = self.iterations.unsignedIntValue;
    }
    {
        encodableStruct.salt = AsByteSpan(self.salt);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRAdministratorCommissioningClusterOpenCommissioningWindowParams (Deprecated)

- (void)setPakeVerifier:(NSData * _Nonnull)pakeVerifier
{
    self.pakePasscodeVerifier = pakeVerifier;
}

- (NSData * _Nonnull)pakeVerifier
{
    return self.pakePasscodeVerifier;
}
@end
@implementation MTRAdministratorCommissioningClusterOpenBasicCommissioningWindowParams
- (instancetype)init
{
    if (self = [super init]) {

        _commissioningTimeout = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAdministratorCommissioningClusterOpenBasicCommissioningWindowParams alloc] init];

    other.commissioningTimeout = self.commissioningTimeout;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: commissioningTimeout:%@; >", NSStringFromClass([self class]), _commissioningTimeout];
    return descriptionString;
}

@end

@implementation MTRAdministratorCommissioningClusterOpenBasicCommissioningWindowParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AdministratorCommissioning::Commands::OpenBasicCommissioningWindow::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.commissioningTimeout = self.commissioningTimeout.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRAdministratorCommissioningClusterRevokeCommissioningParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAdministratorCommissioningClusterRevokeCommissioningParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRAdministratorCommissioningClusterRevokeCommissioningParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AdministratorCommissioning::Commands::RevokeCommissioning::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterAttestationRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _attestationNonce = [NSData data];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterAttestationRequestParams alloc] init];

    other.attestationNonce = self.attestationNonce;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: attestationNonce:%@; >", NSStringFromClass([self class]), [_attestationNonce base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterAttestationRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::AttestationRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.attestationNonce = AsByteSpan(self.attestationNonce);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterAttestationResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _attestationElements = [NSData data];

        _attestationSignature = [NSData data];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterAttestationResponseParams alloc] init];

    other.attestationElements = self.attestationElements;
    other.attestationSignature = self.attestationSignature;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: attestationElements:%@; attestationSignature:%@; >", NSStringFromClass([self class]), [_attestationElements base64EncodedStringWithOptions:0], [_attestationSignature base64EncodedStringWithOptions:0]];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OperationalCredentials::Commands::AttestationResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                do {
                    // AttestationResponse has an extra attestationChallenge field.  Once we
                    // have some sort of more direct decoding from the responseValue, we can
                    // probably make this less hardcoded.
                    //
                    // It might be simpler to look for the right profile tag in the TLV, but let's stick to examining
                    // the responseValue we were handed.
                    id data = responseValue[MTRDataKey];
                    if (![data isKindOfClass:NSDictionary.class]) {
                        err = CHIP_ERROR_INVALID_ARGUMENT;
                        break;
                    }

                    NSDictionary * dataDictionary = data;
                    if (dataDictionary[MTRTypeKey] == nil || ![dataDictionary[MTRTypeKey] isKindOfClass:NSString.class] || ![dataDictionary[MTRTypeKey] isEqualToString:MTRStructureValueType]) {
                        err = CHIP_ERROR_INVALID_ARGUMENT;
                        break;
                    }

                    id value = dataDictionary[MTRValueKey];
                    if (value == nil || ![value isKindOfClass:NSArray.class]) {
                        err = CHIP_ERROR_INVALID_ARGUMENT;
                        break;
                    }

                    NSArray * valueArray = value;
                    for (id item in valueArray) {
                        if (![item isKindOfClass:NSDictionary.class]) {
                            err = CHIP_ERROR_INVALID_ARGUMENT;
                            break;
                        }

                        NSDictionary * itemDictionary = item;
                        id contextTag = itemDictionary[MTRContextTagKey];
                        if (contextTag == nil || ![contextTag isKindOfClass:NSNumber.class]) {
                            err = CHIP_ERROR_INVALID_ARGUMENT;
                            break;
                        }

                        NSNumber * contextTagNumber = contextTag;
                        if (![contextTagNumber isEqualToNumber:@(kAttestationChallengeTagValue)]) {
                            // Not the right field; keep going.
                            continue;
                        }

                        id data = itemDictionary[MTRDataKey];
                        if (data == nil || ![data isKindOfClass:NSDictionary.class]) {
                            err = CHIP_ERROR_INVALID_ARGUMENT;
                            break;
                        }

                        NSDictionary * dataDictionary = data;
                        id dataType = dataDictionary[MTRTypeKey];
                        id dataValue = dataDictionary[MTRValueKey];
                        if (dataType == nil || dataValue == nil || ![dataType isKindOfClass:NSString.class] || ![dataValue isKindOfClass:NSData.class]) {
                            err = CHIP_ERROR_INVALID_ARGUMENT;
                            break;
                        }

                        NSString * dataTypeString = dataType;
                        if (![dataTypeString isEqualToString:MTROctetStringValueType]) {
                            err = CHIP_ERROR_INVALID_ARGUMENT;
                            break;
                        }

                        self.attestationChallenge = dataValue;
                        break;
                    }

                    // Do not add code here without first checking whether err is success.
                } while (0);
            }
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROperationalCredentialsClusterAttestationResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OperationalCredentials::Commands::AttestationResponse::DecodableType &)decodableStruct
{
    {
        self.attestationElements = AsData(decodableStruct.attestationElements);
    }
    {
        self.attestationSignature = AsData(decodableStruct.attestationSignature);
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTROperationalCredentialsClusterAttestationResponseParams (Deprecated)

- (void)setSignature:(NSData * _Nonnull)signature
{
    self.attestationSignature = signature;
}

- (NSData * _Nonnull)signature
{
    return self.attestationSignature;
}
@end
@implementation MTROperationalCredentialsClusterCertificateChainRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _certificateType = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterCertificateChainRequestParams alloc] init];

    other.certificateType = self.certificateType;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: certificateType:%@; >", NSStringFromClass([self class]), _certificateType];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterCertificateChainRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::CertificateChainRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.certificateType = static_cast<std::remove_reference_t<decltype(encodableStruct.certificateType)>>(self.certificateType.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterCertificateChainResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _certificate = [NSData data];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterCertificateChainResponseParams alloc] init];

    other.certificate = self.certificate;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: certificate:%@; >", NSStringFromClass([self class]), [_certificate base64EncodedStringWithOptions:0]];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OperationalCredentials::Commands::CertificateChainResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROperationalCredentialsClusterCertificateChainResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OperationalCredentials::Commands::CertificateChainResponse::DecodableType &)decodableStruct
{
    {
        self.certificate = AsData(decodableStruct.certificate);
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTROperationalCredentialsClusterCSRRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _csrNonce = [NSData data];

        _isForUpdateNOC = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterCSRRequestParams alloc] init];

    other.csrNonce = self.csrNonce;
    other.isForUpdateNOC = self.isForUpdateNOC;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: csrNonce:%@; isForUpdateNOC:%@; >", NSStringFromClass([self class]), [_csrNonce base64EncodedStringWithOptions:0], _isForUpdateNOC];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterCSRRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::CSRRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.CSRNonce = AsByteSpan(self.csrNonce);
    }
    {
        if (self.isForUpdateNOC != nil) {
            auto & definedValue_0 = encodableStruct.isForUpdateNOC.Emplace();
            definedValue_0 = self.isForUpdateNOC.boolValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterCSRResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _nocsrElements = [NSData data];

        _attestationSignature = [NSData data];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterCSRResponseParams alloc] init];

    other.nocsrElements = self.nocsrElements;
    other.attestationSignature = self.attestationSignature;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: nocsrElements:%@; attestationSignature:%@; >", NSStringFromClass([self class]), [_nocsrElements base64EncodedStringWithOptions:0], [_attestationSignature base64EncodedStringWithOptions:0]];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OperationalCredentials::Commands::CSRResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROperationalCredentialsClusterCSRResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OperationalCredentials::Commands::CSRResponse::DecodableType &)decodableStruct
{
    {
        self.nocsrElements = AsData(decodableStruct.NOCSRElements);
    }
    {
        self.attestationSignature = AsData(decodableStruct.attestationSignature);
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTROperationalCredentialsClusterAddNOCParams
- (instancetype)init
{
    if (self = [super init]) {

        _nocValue = [NSData data];

        _icacValue = nil;

        _ipkValue = [NSData data];

        _caseAdminSubject = @(0);

        _adminVendorId = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterAddNOCParams alloc] init];

    other.nocValue = self.nocValue;
    other.icacValue = self.icacValue;
    other.ipkValue = self.ipkValue;
    other.caseAdminSubject = self.caseAdminSubject;
    other.adminVendorId = self.adminVendorId;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: nocValue:%@; icacValue:%@; ipkValue:%@; caseAdminSubject:%@; adminVendorId:%@; >", NSStringFromClass([self class]), [_nocValue base64EncodedStringWithOptions:0], [_icacValue base64EncodedStringWithOptions:0], [_ipkValue base64EncodedStringWithOptions:0], _caseAdminSubject, _adminVendorId];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterAddNOCParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::AddNOC::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.NOCValue = AsByteSpan(self.nocValue);
    }
    {
        if (self.icacValue != nil) {
            auto & definedValue_0 = encodableStruct.ICACValue.Emplace();
            definedValue_0 = AsByteSpan(self.icacValue);
        }
    }
    {
        encodableStruct.IPKValue = AsByteSpan(self.ipkValue);
    }
    {
        encodableStruct.caseAdminSubject = self.caseAdminSubject.unsignedLongLongValue;
    }
    {
        encodableStruct.adminVendorId = static_cast<std::remove_reference_t<decltype(encodableStruct.adminVendorId)>>(self.adminVendorId.unsignedShortValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterUpdateNOCParams
- (instancetype)init
{
    if (self = [super init]) {

        _nocValue = [NSData data];

        _icacValue = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterUpdateNOCParams alloc] init];

    other.nocValue = self.nocValue;
    other.icacValue = self.icacValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: nocValue:%@; icacValue:%@; >", NSStringFromClass([self class]), [_nocValue base64EncodedStringWithOptions:0], [_icacValue base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterUpdateNOCParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::UpdateNOC::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.NOCValue = AsByteSpan(self.nocValue);
    }
    {
        if (self.icacValue != nil) {
            auto & definedValue_0 = encodableStruct.ICACValue.Emplace();
            definedValue_0 = AsByteSpan(self.icacValue);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterNOCResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _statusCode = @(0);

        _fabricIndex = nil;

        _debugText = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterNOCResponseParams alloc] init];

    other.statusCode = self.statusCode;
    other.fabricIndex = self.fabricIndex;
    other.debugText = self.debugText;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: statusCode:%@; fabricIndex:%@; debugText:%@; >", NSStringFromClass([self class]), _statusCode, _fabricIndex, _debugText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OperationalCredentials::Commands::NOCResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROperationalCredentialsClusterNOCResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OperationalCredentials::Commands::NOCResponse::DecodableType &)decodableStruct
{
    {
        self.statusCode = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.statusCode)];
    }
    {
        if (decodableStruct.fabricIndex.HasValue()) {
            self.fabricIndex = [NSNumber numberWithUnsignedChar:decodableStruct.fabricIndex.Value()];
        } else {
            self.fabricIndex = nil;
        }
    }
    {
        if (decodableStruct.debugText.HasValue()) {
            self.debugText = AsString(decodableStruct.debugText.Value());
            if (self.debugText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.debugText = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTROperationalCredentialsClusterUpdateFabricLabelParams
- (instancetype)init
{
    if (self = [super init]) {

        _label = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterUpdateFabricLabelParams alloc] init];

    other.label = self.label;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: label:%@; >", NSStringFromClass([self class]), _label];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterUpdateFabricLabelParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::UpdateFabricLabel::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.label = AsCharSpan(self.label);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterRemoveFabricParams
- (instancetype)init
{
    if (self = [super init]) {

        _fabricIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterRemoveFabricParams alloc] init];

    other.fabricIndex = self.fabricIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: fabricIndex:%@; >", NSStringFromClass([self class]), _fabricIndex];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterRemoveFabricParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::RemoveFabric::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.fabricIndex = self.fabricIndex.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterAddTrustedRootCertificateParams
- (instancetype)init
{
    if (self = [super init]) {

        _rootCACertificate = [NSData data];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalCredentialsClusterAddTrustedRootCertificateParams alloc] init];

    other.rootCACertificate = self.rootCACertificate;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: rootCACertificate:%@; >", NSStringFromClass([self class]), [_rootCACertificate base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTROperationalCredentialsClusterAddTrustedRootCertificateParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalCredentials::Commands::AddTrustedRootCertificate::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.rootCACertificate = AsByteSpan(self.rootCACertificate);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalCredentialsClusterAddTrustedRootCertificateParams (Deprecated)

- (void)setRootCertificate:(NSData * _Nonnull)rootCertificate
{
    self.rootCACertificate = rootCertificate;
}

- (NSData * _Nonnull)rootCertificate
{
    return self.rootCACertificate;
}
@end
@implementation MTRGroupKeyManagementClusterKeySetWriteParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupKeySet = [MTRGroupKeyManagementClusterGroupKeySetStruct new];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupKeyManagementClusterKeySetWriteParams alloc] init];

    other.groupKeySet = self.groupKeySet;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupKeySet:%@; >", NSStringFromClass([self class]), _groupKeySet];
    return descriptionString;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetWriteParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GroupKeyManagement::Commands::KeySetWrite::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupKeySet.groupKeySetID = self.groupKeySet.groupKeySetID.unsignedShortValue;
        encodableStruct.groupKeySet.groupKeySecurityPolicy = static_cast<std::remove_reference_t<decltype(encodableStruct.groupKeySet.groupKeySecurityPolicy)>>(self.groupKeySet.groupKeySecurityPolicy.unsignedCharValue);
        if (self.groupKeySet.epochKey0 == nil) {
            encodableStruct.groupKeySet.epochKey0.SetNull();
        } else {
            auto & nonNullValue_1 = encodableStruct.groupKeySet.epochKey0.SetNonNull();
            nonNullValue_1 = AsByteSpan(self.groupKeySet.epochKey0);
        }
        if (self.groupKeySet.epochStartTime0 == nil) {
            encodableStruct.groupKeySet.epochStartTime0.SetNull();
        } else {
            auto & nonNullValue_1 = encodableStruct.groupKeySet.epochStartTime0.SetNonNull();
            nonNullValue_1 = self.groupKeySet.epochStartTime0.unsignedLongLongValue;
        }
        if (self.groupKeySet.epochKey1 == nil) {
            encodableStruct.groupKeySet.epochKey1.SetNull();
        } else {
            auto & nonNullValue_1 = encodableStruct.groupKeySet.epochKey1.SetNonNull();
            nonNullValue_1 = AsByteSpan(self.groupKeySet.epochKey1);
        }
        if (self.groupKeySet.epochStartTime1 == nil) {
            encodableStruct.groupKeySet.epochStartTime1.SetNull();
        } else {
            auto & nonNullValue_1 = encodableStruct.groupKeySet.epochStartTime1.SetNonNull();
            nonNullValue_1 = self.groupKeySet.epochStartTime1.unsignedLongLongValue;
        }
        if (self.groupKeySet.epochKey2 == nil) {
            encodableStruct.groupKeySet.epochKey2.SetNull();
        } else {
            auto & nonNullValue_1 = encodableStruct.groupKeySet.epochKey2.SetNonNull();
            nonNullValue_1 = AsByteSpan(self.groupKeySet.epochKey2);
        }
        if (self.groupKeySet.epochStartTime2 == nil) {
            encodableStruct.groupKeySet.epochStartTime2.SetNull();
        } else {
            auto & nonNullValue_1 = encodableStruct.groupKeySet.epochStartTime2.SetNonNull();
            nonNullValue_1 = self.groupKeySet.epochStartTime2.unsignedLongLongValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupKeyManagementClusterKeySetReadParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupKeySetID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupKeyManagementClusterKeySetReadParams alloc] init];

    other.groupKeySetID = self.groupKeySetID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupKeySetID:%@; >", NSStringFromClass([self class]), _groupKeySetID];
    return descriptionString;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetReadParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GroupKeyManagement::Commands::KeySetRead::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupKeySetID = self.groupKeySetID.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupKeyManagementClusterKeySetReadResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupKeySet = [MTRGroupKeyManagementClusterGroupKeySetStruct new];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupKeyManagementClusterKeySetReadResponseParams alloc] init];

    other.groupKeySet = self.groupKeySet;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupKeySet:%@; >", NSStringFromClass([self class]), _groupKeySet];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::GroupKeyManagement::Commands::KeySetReadResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetReadResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::GroupKeyManagement::Commands::KeySetReadResponse::DecodableType &)decodableStruct
{
    {
        self.groupKeySet = [MTRGroupKeyManagementClusterGroupKeySetStruct new];
        self.groupKeySet.groupKeySetID = [NSNumber numberWithUnsignedShort:decodableStruct.groupKeySet.groupKeySetID];
        self.groupKeySet.groupKeySecurityPolicy = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.groupKeySet.groupKeySecurityPolicy)];
        if (decodableStruct.groupKeySet.epochKey0.IsNull()) {
            self.groupKeySet.epochKey0 = nil;
        } else {
            self.groupKeySet.epochKey0 = AsData(decodableStruct.groupKeySet.epochKey0.Value());
        }
        if (decodableStruct.groupKeySet.epochStartTime0.IsNull()) {
            self.groupKeySet.epochStartTime0 = nil;
        } else {
            self.groupKeySet.epochStartTime0 = [NSNumber numberWithUnsignedLongLong:decodableStruct.groupKeySet.epochStartTime0.Value()];
        }
        if (decodableStruct.groupKeySet.epochKey1.IsNull()) {
            self.groupKeySet.epochKey1 = nil;
        } else {
            self.groupKeySet.epochKey1 = AsData(decodableStruct.groupKeySet.epochKey1.Value());
        }
        if (decodableStruct.groupKeySet.epochStartTime1.IsNull()) {
            self.groupKeySet.epochStartTime1 = nil;
        } else {
            self.groupKeySet.epochStartTime1 = [NSNumber numberWithUnsignedLongLong:decodableStruct.groupKeySet.epochStartTime1.Value()];
        }
        if (decodableStruct.groupKeySet.epochKey2.IsNull()) {
            self.groupKeySet.epochKey2 = nil;
        } else {
            self.groupKeySet.epochKey2 = AsData(decodableStruct.groupKeySet.epochKey2.Value());
        }
        if (decodableStruct.groupKeySet.epochStartTime2.IsNull()) {
            self.groupKeySet.epochStartTime2 = nil;
        } else {
            self.groupKeySet.epochStartTime2 = [NSNumber numberWithUnsignedLongLong:decodableStruct.groupKeySet.epochStartTime2.Value()];
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetRemoveParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupKeySetID = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupKeyManagementClusterKeySetRemoveParams alloc] init];

    other.groupKeySetID = self.groupKeySetID;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupKeySetID:%@; >", NSStringFromClass([self class]), _groupKeySetID];
    return descriptionString;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetRemoveParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GroupKeyManagement::Commands::KeySetRemove::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.groupKeySetID = self.groupKeySetID.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupKeyManagementClusterKeySetReadAllIndicesParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupKeyManagementClusterKeySetReadAllIndicesParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetReadAllIndicesParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::GroupKeyManagement::Commands::KeySetReadAllIndices::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRGroupKeyManagementClusterKeySetReadAllIndicesResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _groupKeySetIDs = [NSArray array];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRGroupKeyManagementClusterKeySetReadAllIndicesResponseParams alloc] init];

    other.groupKeySetIDs = self.groupKeySetIDs;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: groupKeySetIDs:%@; >", NSStringFromClass([self class]), _groupKeySetIDs];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::GroupKeyManagement::Commands::KeySetReadAllIndicesResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRGroupKeyManagementClusterKeySetReadAllIndicesResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::GroupKeyManagement::Commands::KeySetReadAllIndicesResponse::DecodableType &)decodableStruct
{
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.groupKeySetIDs.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithUnsignedShort:entry_0];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.groupKeySetIDs = array_0;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRICDManagementClusterRegisterClientParams
- (instancetype)init
{
    if (self = [super init]) {

        _checkInNodeID = @(0);

        _monitoredSubject = @(0);

        _key = [NSData data];

        _verificationKey = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRICDManagementClusterRegisterClientParams alloc] init];

    other.checkInNodeID = self.checkInNodeID;
    other.monitoredSubject = self.monitoredSubject;
    other.key = self.key;
    other.verificationKey = self.verificationKey;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: checkInNodeID:%@; monitoredSubject:%@; key:%@; verificationKey:%@; >", NSStringFromClass([self class]), _checkInNodeID, _monitoredSubject, [_key base64EncodedStringWithOptions:0], [_verificationKey base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRICDManagementClusterRegisterClientParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::IcdManagement::Commands::RegisterClient::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.checkInNodeID = self.checkInNodeID.unsignedLongLongValue;
    }
    {
        encodableStruct.monitoredSubject = self.monitoredSubject.unsignedLongLongValue;
    }
    {
        encodableStruct.key = AsByteSpan(self.key);
    }
    {
        if (self.verificationKey != nil) {
            auto & definedValue_0 = encodableStruct.verificationKey.Emplace();
            definedValue_0 = AsByteSpan(self.verificationKey);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRICDManagementClusterRegisterClientResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _icdCounter = @(0);
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRICDManagementClusterRegisterClientResponseParams alloc] init];

    other.icdCounter = self.icdCounter;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: icdCounter:%@; >", NSStringFromClass([self class]), _icdCounter];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::IcdManagement::Commands::RegisterClientResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRICDManagementClusterRegisterClientResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::IcdManagement::Commands::RegisterClientResponse::DecodableType &)decodableStruct
{
    {
        self.icdCounter = [NSNumber numberWithUnsignedInt:decodableStruct.ICDCounter];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRICDManagementClusterUnregisterClientParams
- (instancetype)init
{
    if (self = [super init]) {

        _checkInNodeID = @(0);

        _verificationKey = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRICDManagementClusterUnregisterClientParams alloc] init];

    other.checkInNodeID = self.checkInNodeID;
    other.verificationKey = self.verificationKey;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: checkInNodeID:%@; verificationKey:%@; >", NSStringFromClass([self class]), _checkInNodeID, [_verificationKey base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRICDManagementClusterUnregisterClientParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::IcdManagement::Commands::UnregisterClient::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.checkInNodeID = self.checkInNodeID.unsignedLongLongValue;
    }
    {
        if (self.verificationKey != nil) {
            auto & definedValue_0 = encodableStruct.verificationKey.Emplace();
            definedValue_0 = AsByteSpan(self.verificationKey);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRICDManagementClusterStayActiveRequestParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRICDManagementClusterStayActiveRequestParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRICDManagementClusterStayActiveRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::IcdManagement::Commands::StayActiveRequest::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRModeSelectClusterChangeToModeParams
- (instancetype)init
{
    if (self = [super init]) {

        _newMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRModeSelectClusterChangeToModeParams alloc] init];

    other.newMode = self.newMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newMode:%@; >", NSStringFromClass([self class]), _newMode];
    return descriptionString;
}

@end

@implementation MTRModeSelectClusterChangeToModeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ModeSelect::Commands::ChangeToMode::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newMode = self.newMode.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLaundryWasherModeClusterChangeToModeParams
- (instancetype)init
{
    if (self = [super init]) {

        _newMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLaundryWasherModeClusterChangeToModeParams alloc] init];

    other.newMode = self.newMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newMode:%@; >", NSStringFromClass([self class]), _newMode];
    return descriptionString;
}

@end

@implementation MTRLaundryWasherModeClusterChangeToModeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LaundryWasherMode::Commands::ChangeToMode::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newMode = self.newMode.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLaundryWasherModeClusterChangeToModeResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _statusText = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLaundryWasherModeClusterChangeToModeResponseParams alloc] init];

    other.status = self.status;
    other.statusText = self.statusText;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; statusText:%@; >", NSStringFromClass([self class]), _status, _statusText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::LaundryWasherMode::Commands::ChangeToModeResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRLaundryWasherModeClusterChangeToModeResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::LaundryWasherMode::Commands::ChangeToModeResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        if (decodableStruct.statusText.HasValue()) {
            self.statusText = AsString(decodableStruct.statusText.Value());
            if (self.statusText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.statusText = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRRefrigeratorAndTemperatureControlledCabinetModeClusterChangeToModeParams
- (instancetype)init
{
    if (self = [super init]) {

        _newMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRefrigeratorAndTemperatureControlledCabinetModeClusterChangeToModeParams alloc] init];

    other.newMode = self.newMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newMode:%@; >", NSStringFromClass([self class]), _newMode];
    return descriptionString;
}

@end

@implementation MTRRefrigeratorAndTemperatureControlledCabinetModeClusterChangeToModeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RefrigeratorAndTemperatureControlledCabinetMode::Commands::ChangeToMode::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newMode = self.newMode.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRefrigeratorAndTemperatureControlledCabinetModeClusterChangeToModeResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _statusText = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRefrigeratorAndTemperatureControlledCabinetModeClusterChangeToModeResponseParams alloc] init];

    other.status = self.status;
    other.statusText = self.statusText;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; statusText:%@; >", NSStringFromClass([self class]), _status, _statusText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::RefrigeratorAndTemperatureControlledCabinetMode::Commands::ChangeToModeResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRRefrigeratorAndTemperatureControlledCabinetModeClusterChangeToModeResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::RefrigeratorAndTemperatureControlledCabinetMode::Commands::ChangeToModeResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        if (decodableStruct.statusText.HasValue()) {
            self.statusText = AsString(decodableStruct.statusText.Value());
            if (self.statusText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.statusText = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRRVCRunModeClusterChangeToModeParams
- (instancetype)init
{
    if (self = [super init]) {

        _newMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCRunModeClusterChangeToModeParams alloc] init];

    other.newMode = self.newMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newMode:%@; >", NSStringFromClass([self class]), _newMode];
    return descriptionString;
}

@end

@implementation MTRRVCRunModeClusterChangeToModeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RvcRunMode::Commands::ChangeToMode::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newMode = self.newMode.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRVCRunModeClusterChangeToModeResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _statusText = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCRunModeClusterChangeToModeResponseParams alloc] init];

    other.status = self.status;
    other.statusText = self.statusText;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; statusText:%@; >", NSStringFromClass([self class]), _status, _statusText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::RvcRunMode::Commands::ChangeToModeResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRRVCRunModeClusterChangeToModeResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::RvcRunMode::Commands::ChangeToModeResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        if (decodableStruct.statusText.HasValue()) {
            self.statusText = AsString(decodableStruct.statusText.Value());
            if (self.statusText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.statusText = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRRVCCleanModeClusterChangeToModeParams
- (instancetype)init
{
    if (self = [super init]) {

        _newMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCCleanModeClusterChangeToModeParams alloc] init];

    other.newMode = self.newMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newMode:%@; >", NSStringFromClass([self class]), _newMode];
    return descriptionString;
}

@end

@implementation MTRRVCCleanModeClusterChangeToModeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RvcCleanMode::Commands::ChangeToMode::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newMode = self.newMode.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRVCCleanModeClusterChangeToModeResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _statusText = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCCleanModeClusterChangeToModeResponseParams alloc] init];

    other.status = self.status;
    other.statusText = self.statusText;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; statusText:%@; >", NSStringFromClass([self class]), _status, _statusText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::RvcCleanMode::Commands::ChangeToModeResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRRVCCleanModeClusterChangeToModeResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::RvcCleanMode::Commands::ChangeToModeResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        if (decodableStruct.statusText.HasValue()) {
            self.statusText = AsString(decodableStruct.statusText.Value());
            if (self.statusText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.statusText = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTemperatureControlClusterSetTemperatureParams
- (instancetype)init
{
    if (self = [super init]) {

        _targetTemperature = nil;

        _targetTemperatureLevel = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTemperatureControlClusterSetTemperatureParams alloc] init];

    other.targetTemperature = self.targetTemperature;
    other.targetTemperatureLevel = self.targetTemperatureLevel;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: targetTemperature:%@; targetTemperatureLevel:%@; >", NSStringFromClass([self class]), _targetTemperature, _targetTemperatureLevel];
    return descriptionString;
}

@end

@implementation MTRTemperatureControlClusterSetTemperatureParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TemperatureControl::Commands::SetTemperature::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.targetTemperature != nil) {
            auto & definedValue_0 = encodableStruct.targetTemperature.Emplace();
            definedValue_0 = self.targetTemperature.shortValue;
        }
    }
    {
        if (self.targetTemperatureLevel != nil) {
            auto & definedValue_0 = encodableStruct.targetTemperatureLevel.Emplace();
            definedValue_0 = self.targetTemperatureLevel.unsignedCharValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDishwasherModeClusterChangeToModeParams
- (instancetype)init
{
    if (self = [super init]) {

        _newMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDishwasherModeClusterChangeToModeParams alloc] init];

    other.newMode = self.newMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: newMode:%@; >", NSStringFromClass([self class]), _newMode];
    return descriptionString;
}

@end

@implementation MTRDishwasherModeClusterChangeToModeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DishwasherMode::Commands::ChangeToMode::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.newMode = self.newMode.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDishwasherModeClusterChangeToModeResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _statusText = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDishwasherModeClusterChangeToModeResponseParams alloc] init];

    other.status = self.status;
    other.statusText = self.statusText;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; statusText:%@; >", NSStringFromClass([self class]), _status, _statusText];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DishwasherMode::Commands::ChangeToModeResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDishwasherModeClusterChangeToModeResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DishwasherMode::Commands::ChangeToModeResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        if (decodableStruct.statusText.HasValue()) {
            self.statusText = AsString(decodableStruct.statusText.Value());
            if (self.statusText == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.statusText = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRSmokeCOAlarmClusterSelfTestRequestParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRSmokeCOAlarmClusterSelfTestRequestParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRSmokeCOAlarmClusterSelfTestRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::SmokeCoAlarm::Commands::SelfTestRequest::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDishwasherAlarmClusterResetParams
- (instancetype)init
{
    if (self = [super init]) {

        _alarms = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDishwasherAlarmClusterResetParams alloc] init];

    other.alarms = self.alarms;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: alarms:%@; >", NSStringFromClass([self class]), _alarms];
    return descriptionString;
}

@end

@implementation MTRDishwasherAlarmClusterResetParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DishwasherAlarm::Commands::Reset::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.alarms = static_cast<std::remove_reference_t<decltype(encodableStruct.alarms)>>(self.alarms.unsignedIntValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDishwasherAlarmClusterModifyEnabledAlarmsParams
- (instancetype)init
{
    if (self = [super init]) {

        _mask = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDishwasherAlarmClusterModifyEnabledAlarmsParams alloc] init];

    other.mask = self.mask;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: mask:%@; >", NSStringFromClass([self class]), _mask];
    return descriptionString;
}

@end

@implementation MTRDishwasherAlarmClusterModifyEnabledAlarmsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DishwasherAlarm::Commands::ModifyEnabledAlarms::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.mask = static_cast<std::remove_reference_t<decltype(encodableStruct.mask)>>(self.mask.unsignedIntValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalStateClusterPauseParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalStateClusterPauseParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROperationalStateClusterPauseParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalState::Commands::Pause::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalStateClusterStopParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalStateClusterStopParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROperationalStateClusterStopParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalState::Commands::Stop::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalStateClusterStartParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalStateClusterStartParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROperationalStateClusterStartParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalState::Commands::Start::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalStateClusterResumeParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalStateClusterResumeParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTROperationalStateClusterResumeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::OperationalState::Commands::Resume::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTROperationalStateClusterOperationalCommandResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _commandResponseState = [MTROperationalStateClusterErrorStateStruct new];
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTROperationalStateClusterOperationalCommandResponseParams alloc] init];

    other.commandResponseState = self.commandResponseState;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: commandResponseState:%@; >", NSStringFromClass([self class]), _commandResponseState];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::OperationalState::Commands::OperationalCommandResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTROperationalStateClusterOperationalCommandResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::OperationalState::Commands::OperationalCommandResponse::DecodableType &)decodableStruct
{
    {
        self.commandResponseState = [MTROperationalStateClusterErrorStateStruct new];
        self.commandResponseState.errorStateID = [NSNumber numberWithUnsignedChar:decodableStruct.commandResponseState.errorStateID];
        if (decodableStruct.commandResponseState.errorStateLabel.HasValue()) {
            self.commandResponseState.errorStateLabel = AsString(decodableStruct.commandResponseState.errorStateLabel.Value());
            if (self.commandResponseState.errorStateLabel == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.commandResponseState.errorStateLabel = nil;
        }
        if (decodableStruct.commandResponseState.errorStateDetails.HasValue()) {
            self.commandResponseState.errorStateDetails = AsString(decodableStruct.commandResponseState.errorStateDetails.Value());
            if (self.commandResponseState.errorStateDetails == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.commandResponseState.errorStateDetails = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRRVCOperationalStateClusterPauseParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCOperationalStateClusterPauseParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRRVCOperationalStateClusterPauseParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RvcOperationalState::Commands::Pause::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRVCOperationalStateClusterStopParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCOperationalStateClusterStopParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRRVCOperationalStateClusterStopParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RvcOperationalState::Commands::Stop::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRVCOperationalStateClusterStartParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCOperationalStateClusterStartParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRRVCOperationalStateClusterStartParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RvcOperationalState::Commands::Start::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRVCOperationalStateClusterResumeParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCOperationalStateClusterResumeParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRRVCOperationalStateClusterResumeParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::RvcOperationalState::Commands::Resume::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRRVCOperationalStateClusterOperationalCommandResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _commandResponseState = [MTRRVCOperationalStateClusterErrorStateStruct new];
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRRVCOperationalStateClusterOperationalCommandResponseParams alloc] init];

    other.commandResponseState = self.commandResponseState;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: commandResponseState:%@; >", NSStringFromClass([self class]), _commandResponseState];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::RvcOperationalState::Commands::OperationalCommandResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRRVCOperationalStateClusterOperationalCommandResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::RvcOperationalState::Commands::OperationalCommandResponse::DecodableType &)decodableStruct
{
    {
        self.commandResponseState = [MTRRVCOperationalStateClusterErrorStateStruct new];
        self.commandResponseState.errorStateID = [NSNumber numberWithUnsignedChar:decodableStruct.commandResponseState.errorStateID];
        if (decodableStruct.commandResponseState.errorStateLabel.HasValue()) {
            self.commandResponseState.errorStateLabel = AsString(decodableStruct.commandResponseState.errorStateLabel.Value());
            if (self.commandResponseState.errorStateLabel == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.commandResponseState.errorStateLabel = nil;
        }
        if (decodableStruct.commandResponseState.errorStateDetails.HasValue()) {
            self.commandResponseState.errorStateDetails = AsString(decodableStruct.commandResponseState.errorStateDetails.Value());
            if (self.commandResponseState.errorStateDetails == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.commandResponseState.errorStateDetails = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRHEPAFilterMonitoringClusterResetConditionParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRHEPAFilterMonitoringClusterResetConditionParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRHEPAFilterMonitoringClusterResetConditionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::HepaFilterMonitoring::Commands::ResetCondition::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRActivatedCarbonFilterMonitoringClusterResetConditionParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRActivatedCarbonFilterMonitoringClusterResetConditionParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRActivatedCarbonFilterMonitoringClusterResetConditionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ActivatedCarbonFilterMonitoring::Commands::ResetCondition::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterLockDoorParams
- (instancetype)init
{
    if (self = [super init]) {

        _pinCode = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterLockDoorParams alloc] init];

    other.pinCode = self.pinCode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: pinCode:%@; >", NSStringFromClass([self class]), [_pinCode base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterLockDoorParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::LockDoor::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.pinCode != nil) {
            auto & definedValue_0 = encodableStruct.PINCode.Emplace();
            definedValue_0 = AsByteSpan(self.pinCode);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterUnlockDoorParams
- (instancetype)init
{
    if (self = [super init]) {

        _pinCode = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterUnlockDoorParams alloc] init];

    other.pinCode = self.pinCode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: pinCode:%@; >", NSStringFromClass([self class]), [_pinCode base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterUnlockDoorParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::UnlockDoor::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.pinCode != nil) {
            auto & definedValue_0 = encodableStruct.PINCode.Emplace();
            definedValue_0 = AsByteSpan(self.pinCode);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterUnlockWithTimeoutParams
- (instancetype)init
{
    if (self = [super init]) {

        _timeout = @(0);

        _pinCode = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterUnlockWithTimeoutParams alloc] init];

    other.timeout = self.timeout;
    other.pinCode = self.pinCode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: timeout:%@; pinCode:%@; >", NSStringFromClass([self class]), _timeout, [_pinCode base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterUnlockWithTimeoutParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::UnlockWithTimeout::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.timeout = self.timeout.unsignedShortValue;
    }
    {
        if (self.pinCode != nil) {
            auto & definedValue_0 = encodableStruct.PINCode.Emplace();
            definedValue_0 = AsByteSpan(self.pinCode);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetWeekDayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _weekDayIndex = @(0);

        _userIndex = @(0);

        _daysMask = @(0);

        _startHour = @(0);

        _startMinute = @(0);

        _endHour = @(0);

        _endMinute = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterSetWeekDayScheduleParams alloc] init];

    other.weekDayIndex = self.weekDayIndex;
    other.userIndex = self.userIndex;
    other.daysMask = self.daysMask;
    other.startHour = self.startHour;
    other.startMinute = self.startMinute;
    other.endHour = self.endHour;
    other.endMinute = self.endMinute;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: weekDayIndex:%@; userIndex:%@; daysMask:%@; startHour:%@; startMinute:%@; endHour:%@; endMinute:%@; >", NSStringFromClass([self class]), _weekDayIndex, _userIndex, _daysMask, _startHour, _startMinute, _endHour, _endMinute];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterSetWeekDayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::SetWeekDaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.weekDayIndex = self.weekDayIndex.unsignedCharValue;
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }
    {
        encodableStruct.daysMask = static_cast<std::remove_reference_t<decltype(encodableStruct.daysMask)>>(self.daysMask.unsignedCharValue);
    }
    {
        encodableStruct.startHour = self.startHour.unsignedCharValue;
    }
    {
        encodableStruct.startMinute = self.startMinute.unsignedCharValue;
    }
    {
        encodableStruct.endHour = self.endHour.unsignedCharValue;
    }
    {
        encodableStruct.endMinute = self.endMinute.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetWeekDayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _weekDayIndex = @(0);

        _userIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetWeekDayScheduleParams alloc] init];

    other.weekDayIndex = self.weekDayIndex;
    other.userIndex = self.userIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: weekDayIndex:%@; userIndex:%@; >", NSStringFromClass([self class]), _weekDayIndex, _userIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterGetWeekDayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::GetWeekDaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.weekDayIndex = self.weekDayIndex.unsignedCharValue;
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetWeekDayScheduleResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _weekDayIndex = @(0);

        _userIndex = @(0);

        _status = @(0);

        _daysMask = nil;

        _startHour = nil;

        _startMinute = nil;

        _endHour = nil;

        _endMinute = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetWeekDayScheduleResponseParams alloc] init];

    other.weekDayIndex = self.weekDayIndex;
    other.userIndex = self.userIndex;
    other.status = self.status;
    other.daysMask = self.daysMask;
    other.startHour = self.startHour;
    other.startMinute = self.startMinute;
    other.endHour = self.endHour;
    other.endMinute = self.endMinute;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: weekDayIndex:%@; userIndex:%@; status:%@; daysMask:%@; startHour:%@; startMinute:%@; endHour:%@; endMinute:%@; >", NSStringFromClass([self class]), _weekDayIndex, _userIndex, _status, _daysMask, _startHour, _startMinute, _endHour, _endMinute];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DoorLock::Commands::GetWeekDayScheduleResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDoorLockClusterGetWeekDayScheduleResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DoorLock::Commands::GetWeekDayScheduleResponse::DecodableType &)decodableStruct
{
    {
        self.weekDayIndex = [NSNumber numberWithUnsignedChar:decodableStruct.weekDayIndex];
    }
    {
        self.userIndex = [NSNumber numberWithUnsignedShort:decodableStruct.userIndex];
    }
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.daysMask.HasValue()) {
            self.daysMask = [NSNumber numberWithUnsignedChar:decodableStruct.daysMask.Value().Raw()];
        } else {
            self.daysMask = nil;
        }
    }
    {
        if (decodableStruct.startHour.HasValue()) {
            self.startHour = [NSNumber numberWithUnsignedChar:decodableStruct.startHour.Value()];
        } else {
            self.startHour = nil;
        }
    }
    {
        if (decodableStruct.startMinute.HasValue()) {
            self.startMinute = [NSNumber numberWithUnsignedChar:decodableStruct.startMinute.Value()];
        } else {
            self.startMinute = nil;
        }
    }
    {
        if (decodableStruct.endHour.HasValue()) {
            self.endHour = [NSNumber numberWithUnsignedChar:decodableStruct.endHour.Value()];
        } else {
            self.endHour = nil;
        }
    }
    {
        if (decodableStruct.endMinute.HasValue()) {
            self.endMinute = [NSNumber numberWithUnsignedChar:decodableStruct.endMinute.Value()];
        } else {
            self.endMinute = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDoorLockClusterClearWeekDayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _weekDayIndex = @(0);

        _userIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterClearWeekDayScheduleParams alloc] init];

    other.weekDayIndex = self.weekDayIndex;
    other.userIndex = self.userIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: weekDayIndex:%@; userIndex:%@; >", NSStringFromClass([self class]), _weekDayIndex, _userIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterClearWeekDayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::ClearWeekDaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.weekDayIndex = self.weekDayIndex.unsignedCharValue;
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetYearDayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _yearDayIndex = @(0);

        _userIndex = @(0);

        _localStartTime = @(0);

        _localEndTime = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterSetYearDayScheduleParams alloc] init];

    other.yearDayIndex = self.yearDayIndex;
    other.userIndex = self.userIndex;
    other.localStartTime = self.localStartTime;
    other.localEndTime = self.localEndTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: yearDayIndex:%@; userIndex:%@; localStartTime:%@; localEndTime:%@; >", NSStringFromClass([self class]), _yearDayIndex, _userIndex, _localStartTime, _localEndTime];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterSetYearDayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::SetYearDaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.yearDayIndex = self.yearDayIndex.unsignedCharValue;
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }
    {
        encodableStruct.localStartTime = self.localStartTime.unsignedIntValue;
    }
    {
        encodableStruct.localEndTime = self.localEndTime.unsignedIntValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetYearDayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _yearDayIndex = @(0);

        _userIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetYearDayScheduleParams alloc] init];

    other.yearDayIndex = self.yearDayIndex;
    other.userIndex = self.userIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: yearDayIndex:%@; userIndex:%@; >", NSStringFromClass([self class]), _yearDayIndex, _userIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterGetYearDayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::GetYearDaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.yearDayIndex = self.yearDayIndex.unsignedCharValue;
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetYearDayScheduleResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _yearDayIndex = @(0);

        _userIndex = @(0);

        _status = @(0);

        _localStartTime = nil;

        _localEndTime = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetYearDayScheduleResponseParams alloc] init];

    other.yearDayIndex = self.yearDayIndex;
    other.userIndex = self.userIndex;
    other.status = self.status;
    other.localStartTime = self.localStartTime;
    other.localEndTime = self.localEndTime;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: yearDayIndex:%@; userIndex:%@; status:%@; localStartTime:%@; localEndTime:%@; >", NSStringFromClass([self class]), _yearDayIndex, _userIndex, _status, _localStartTime, _localEndTime];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DoorLock::Commands::GetYearDayScheduleResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDoorLockClusterGetYearDayScheduleResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DoorLock::Commands::GetYearDayScheduleResponse::DecodableType &)decodableStruct
{
    {
        self.yearDayIndex = [NSNumber numberWithUnsignedChar:decodableStruct.yearDayIndex];
    }
    {
        self.userIndex = [NSNumber numberWithUnsignedShort:decodableStruct.userIndex];
    }
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.localStartTime.HasValue()) {
            self.localStartTime = [NSNumber numberWithUnsignedInt:decodableStruct.localStartTime.Value()];
        } else {
            self.localStartTime = nil;
        }
    }
    {
        if (decodableStruct.localEndTime.HasValue()) {
            self.localEndTime = [NSNumber numberWithUnsignedInt:decodableStruct.localEndTime.Value()];
        } else {
            self.localEndTime = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDoorLockClusterClearYearDayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _yearDayIndex = @(0);

        _userIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterClearYearDayScheduleParams alloc] init];

    other.yearDayIndex = self.yearDayIndex;
    other.userIndex = self.userIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: yearDayIndex:%@; userIndex:%@; >", NSStringFromClass([self class]), _yearDayIndex, _userIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterClearYearDayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::ClearYearDaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.yearDayIndex = self.yearDayIndex.unsignedCharValue;
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetHolidayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _holidayIndex = @(0);

        _localStartTime = @(0);

        _localEndTime = @(0);

        _operatingMode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterSetHolidayScheduleParams alloc] init];

    other.holidayIndex = self.holidayIndex;
    other.localStartTime = self.localStartTime;
    other.localEndTime = self.localEndTime;
    other.operatingMode = self.operatingMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: holidayIndex:%@; localStartTime:%@; localEndTime:%@; operatingMode:%@; >", NSStringFromClass([self class]), _holidayIndex, _localStartTime, _localEndTime, _operatingMode];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterSetHolidayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::SetHolidaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.holidayIndex = self.holidayIndex.unsignedCharValue;
    }
    {
        encodableStruct.localStartTime = self.localStartTime.unsignedIntValue;
    }
    {
        encodableStruct.localEndTime = self.localEndTime.unsignedIntValue;
    }
    {
        encodableStruct.operatingMode = static_cast<std::remove_reference_t<decltype(encodableStruct.operatingMode)>>(self.operatingMode.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetHolidayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _holidayIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetHolidayScheduleParams alloc] init];

    other.holidayIndex = self.holidayIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: holidayIndex:%@; >", NSStringFromClass([self class]), _holidayIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterGetHolidayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::GetHolidaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.holidayIndex = self.holidayIndex.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetHolidayScheduleResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _holidayIndex = @(0);

        _status = @(0);

        _localStartTime = nil;

        _localEndTime = nil;

        _operatingMode = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetHolidayScheduleResponseParams alloc] init];

    other.holidayIndex = self.holidayIndex;
    other.status = self.status;
    other.localStartTime = self.localStartTime;
    other.localEndTime = self.localEndTime;
    other.operatingMode = self.operatingMode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: holidayIndex:%@; status:%@; localStartTime:%@; localEndTime:%@; operatingMode:%@; >", NSStringFromClass([self class]), _holidayIndex, _status, _localStartTime, _localEndTime, _operatingMode];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DoorLock::Commands::GetHolidayScheduleResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDoorLockClusterGetHolidayScheduleResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DoorLock::Commands::GetHolidayScheduleResponse::DecodableType &)decodableStruct
{
    {
        self.holidayIndex = [NSNumber numberWithUnsignedChar:decodableStruct.holidayIndex];
    }
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.localStartTime.HasValue()) {
            self.localStartTime = [NSNumber numberWithUnsignedInt:decodableStruct.localStartTime.Value()];
        } else {
            self.localStartTime = nil;
        }
    }
    {
        if (decodableStruct.localEndTime.HasValue()) {
            self.localEndTime = [NSNumber numberWithUnsignedInt:decodableStruct.localEndTime.Value()];
        } else {
            self.localEndTime = nil;
        }
    }
    {
        if (decodableStruct.operatingMode.HasValue()) {
            self.operatingMode = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.operatingMode.Value())];
        } else {
            self.operatingMode = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDoorLockClusterClearHolidayScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _holidayIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterClearHolidayScheduleParams alloc] init];

    other.holidayIndex = self.holidayIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: holidayIndex:%@; >", NSStringFromClass([self class]), _holidayIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterClearHolidayScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::ClearHolidaySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.holidayIndex = self.holidayIndex.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetUserParams
- (instancetype)init
{
    if (self = [super init]) {

        _operationType = @(0);

        _userIndex = @(0);

        _userName = nil;

        _userUniqueID = nil;

        _userStatus = nil;

        _userType = nil;

        _credentialRule = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterSetUserParams alloc] init];

    other.operationType = self.operationType;
    other.userIndex = self.userIndex;
    other.userName = self.userName;
    other.userUniqueID = self.userUniqueID;
    other.userStatus = self.userStatus;
    other.userType = self.userType;
    other.credentialRule = self.credentialRule;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: operationType:%@; userIndex:%@; userName:%@; userUniqueID:%@; userStatus:%@; userType:%@; credentialRule:%@; >", NSStringFromClass([self class]), _operationType, _userIndex, _userName, _userUniqueID, _userStatus, _userType, _credentialRule];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterSetUserParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::SetUser::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.operationType = static_cast<std::remove_reference_t<decltype(encodableStruct.operationType)>>(self.operationType.unsignedCharValue);
    }
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }
    {
        if (self.userName == nil) {
            encodableStruct.userName.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userName.SetNonNull();
            nonNullValue_0 = AsCharSpan(self.userName);
        }
    }
    {
        if (self.userUniqueID == nil) {
            encodableStruct.userUniqueID.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userUniqueID.SetNonNull();
            nonNullValue_0 = self.userUniqueID.unsignedIntValue;
        }
    }
    {
        if (self.userStatus == nil) {
            encodableStruct.userStatus.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userStatus.SetNonNull();
            nonNullValue_0 = static_cast<std::remove_reference_t<decltype(nonNullValue_0)>>(self.userStatus.unsignedCharValue);
        }
    }
    {
        if (self.userType == nil) {
            encodableStruct.userType.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userType.SetNonNull();
            nonNullValue_0 = static_cast<std::remove_reference_t<decltype(nonNullValue_0)>>(self.userType.unsignedCharValue);
        }
    }
    {
        if (self.credentialRule == nil) {
            encodableStruct.credentialRule.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.credentialRule.SetNonNull();
            nonNullValue_0 = static_cast<std::remove_reference_t<decltype(nonNullValue_0)>>(self.credentialRule.unsignedCharValue);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetUserParams (Deprecated)

- (void)setUserUniqueId:(NSNumber * _Nullable)userUniqueId
{
    self.userUniqueID = userUniqueId;
}

- (NSNumber * _Nullable)userUniqueId
{
    return self.userUniqueID;
}
@end
@implementation MTRDoorLockClusterGetUserParams
- (instancetype)init
{
    if (self = [super init]) {

        _userIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetUserParams alloc] init];

    other.userIndex = self.userIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: userIndex:%@; >", NSStringFromClass([self class]), _userIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterGetUserParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::GetUser::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetUserResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _userIndex = @(0);

        _userName = nil;

        _userUniqueID = nil;

        _userStatus = nil;

        _userType = nil;

        _credentialRule = nil;

        _credentials = nil;

        _creatorFabricIndex = nil;

        _lastModifiedFabricIndex = nil;

        _nextUserIndex = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetUserResponseParams alloc] init];

    other.userIndex = self.userIndex;
    other.userName = self.userName;
    other.userUniqueID = self.userUniqueID;
    other.userStatus = self.userStatus;
    other.userType = self.userType;
    other.credentialRule = self.credentialRule;
    other.credentials = self.credentials;
    other.creatorFabricIndex = self.creatorFabricIndex;
    other.lastModifiedFabricIndex = self.lastModifiedFabricIndex;
    other.nextUserIndex = self.nextUserIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: userIndex:%@; userName:%@; userUniqueID:%@; userStatus:%@; userType:%@; credentialRule:%@; credentials:%@; creatorFabricIndex:%@; lastModifiedFabricIndex:%@; nextUserIndex:%@; >", NSStringFromClass([self class]), _userIndex, _userName, _userUniqueID, _userStatus, _userType, _credentialRule, _credentials, _creatorFabricIndex, _lastModifiedFabricIndex, _nextUserIndex];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DoorLock::Commands::GetUserResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDoorLockClusterGetUserResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DoorLock::Commands::GetUserResponse::DecodableType &)decodableStruct
{
    {
        self.userIndex = [NSNumber numberWithUnsignedShort:decodableStruct.userIndex];
    }
    {
        if (decodableStruct.userName.IsNull()) {
            self.userName = nil;
        } else {
            self.userName = AsString(decodableStruct.userName.Value());
            if (self.userName == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        }
    }
    {
        if (decodableStruct.userUniqueID.IsNull()) {
            self.userUniqueID = nil;
        } else {
            self.userUniqueID = [NSNumber numberWithUnsignedInt:decodableStruct.userUniqueID.Value()];
        }
    }
    {
        if (decodableStruct.userStatus.IsNull()) {
            self.userStatus = nil;
        } else {
            self.userStatus = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.userStatus.Value())];
        }
    }
    {
        if (decodableStruct.userType.IsNull()) {
            self.userType = nil;
        } else {
            self.userType = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.userType.Value())];
        }
    }
    {
        if (decodableStruct.credentialRule.IsNull()) {
            self.credentialRule = nil;
        } else {
            self.credentialRule = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.credentialRule.Value())];
        }
    }
    {
        if (decodableStruct.credentials.IsNull()) {
            self.credentials = nil;
        } else {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.credentials.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    MTRDoorLockClusterCredentialStruct * newElement_1;
                    newElement_1 = [MTRDoorLockClusterCredentialStruct new];
                    newElement_1.credentialType = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_1.credentialType)];
                    newElement_1.credentialIndex = [NSNumber numberWithUnsignedShort:entry_1.credentialIndex];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.credentials = array_1;
            }
        }
    }
    {
        if (decodableStruct.creatorFabricIndex.IsNull()) {
            self.creatorFabricIndex = nil;
        } else {
            self.creatorFabricIndex = [NSNumber numberWithUnsignedChar:decodableStruct.creatorFabricIndex.Value()];
        }
    }
    {
        if (decodableStruct.lastModifiedFabricIndex.IsNull()) {
            self.lastModifiedFabricIndex = nil;
        } else {
            self.lastModifiedFabricIndex = [NSNumber numberWithUnsignedChar:decodableStruct.lastModifiedFabricIndex.Value()];
        }
    }
    {
        if (decodableStruct.nextUserIndex.IsNull()) {
            self.nextUserIndex = nil;
        } else {
            self.nextUserIndex = [NSNumber numberWithUnsignedShort:decodableStruct.nextUserIndex.Value()];
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDoorLockClusterGetUserResponseParams (Deprecated)

- (void)setUserUniqueId:(NSNumber * _Nullable)userUniqueId
{
    self.userUniqueID = userUniqueId;
}

- (NSNumber * _Nullable)userUniqueId
{
    return self.userUniqueID;
}
@end
@implementation MTRDoorLockClusterClearUserParams
- (instancetype)init
{
    if (self = [super init]) {

        _userIndex = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterClearUserParams alloc] init];

    other.userIndex = self.userIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: userIndex:%@; >", NSStringFromClass([self class]), _userIndex];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterClearUserParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::ClearUser::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.userIndex = self.userIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetCredentialParams
- (instancetype)init
{
    if (self = [super init]) {

        _operationType = @(0);

        _credential = [MTRDoorLockClusterCredentialStruct new];

        _credentialData = [NSData data];

        _userIndex = nil;

        _userStatus = nil;

        _userType = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterSetCredentialParams alloc] init];

    other.operationType = self.operationType;
    other.credential = self.credential;
    other.credentialData = self.credentialData;
    other.userIndex = self.userIndex;
    other.userStatus = self.userStatus;
    other.userType = self.userType;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: operationType:%@; credential:%@; credentialData:%@; userIndex:%@; userStatus:%@; userType:%@; >", NSStringFromClass([self class]), _operationType, _credential, [_credentialData base64EncodedStringWithOptions:0], _userIndex, _userStatus, _userType];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterSetCredentialParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::SetCredential::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.operationType = static_cast<std::remove_reference_t<decltype(encodableStruct.operationType)>>(self.operationType.unsignedCharValue);
    }
    {
        encodableStruct.credential.credentialType = static_cast<std::remove_reference_t<decltype(encodableStruct.credential.credentialType)>>(self.credential.credentialType.unsignedCharValue);
        encodableStruct.credential.credentialIndex = self.credential.credentialIndex.unsignedShortValue;
    }
    {
        encodableStruct.credentialData = AsByteSpan(self.credentialData);
    }
    {
        if (self.userIndex == nil) {
            encodableStruct.userIndex.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userIndex.SetNonNull();
            nonNullValue_0 = self.userIndex.unsignedShortValue;
        }
    }
    {
        if (self.userStatus == nil) {
            encodableStruct.userStatus.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userStatus.SetNonNull();
            nonNullValue_0 = static_cast<std::remove_reference_t<decltype(nonNullValue_0)>>(self.userStatus.unsignedCharValue);
        }
    }
    {
        if (self.userType == nil) {
            encodableStruct.userType.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.userType.SetNonNull();
            nonNullValue_0 = static_cast<std::remove_reference_t<decltype(nonNullValue_0)>>(self.userType.unsignedCharValue);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterSetCredentialResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _userIndex = nil;

        _nextCredentialIndex = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterSetCredentialResponseParams alloc] init];

    other.status = self.status;
    other.userIndex = self.userIndex;
    other.nextCredentialIndex = self.nextCredentialIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; userIndex:%@; nextCredentialIndex:%@; >", NSStringFromClass([self class]), _status, _userIndex, _nextCredentialIndex];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DoorLock::Commands::SetCredentialResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDoorLockClusterSetCredentialResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DoorLock::Commands::SetCredentialResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.userIndex.IsNull()) {
            self.userIndex = nil;
        } else {
            self.userIndex = [NSNumber numberWithUnsignedShort:decodableStruct.userIndex.Value()];
        }
    }
    {
        if (decodableStruct.nextCredentialIndex.IsNull()) {
            self.nextCredentialIndex = nil;
        } else {
            self.nextCredentialIndex = [NSNumber numberWithUnsignedShort:decodableStruct.nextCredentialIndex.Value()];
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDoorLockClusterGetCredentialStatusParams
- (instancetype)init
{
    if (self = [super init]) {

        _credential = [MTRDoorLockClusterCredentialStruct new];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetCredentialStatusParams alloc] init];

    other.credential = self.credential;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: credential:%@; >", NSStringFromClass([self class]), _credential];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterGetCredentialStatusParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::GetCredentialStatus::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.credential.credentialType = static_cast<std::remove_reference_t<decltype(encodableStruct.credential.credentialType)>>(self.credential.credentialType.unsignedCharValue);
        encodableStruct.credential.credentialIndex = self.credential.credentialIndex.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterGetCredentialStatusResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _credentialExists = @(0);

        _userIndex = nil;

        _creatorFabricIndex = nil;

        _lastModifiedFabricIndex = nil;

        _nextCredentialIndex = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterGetCredentialStatusResponseParams alloc] init];

    other.credentialExists = self.credentialExists;
    other.userIndex = self.userIndex;
    other.creatorFabricIndex = self.creatorFabricIndex;
    other.lastModifiedFabricIndex = self.lastModifiedFabricIndex;
    other.nextCredentialIndex = self.nextCredentialIndex;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: credentialExists:%@; userIndex:%@; creatorFabricIndex:%@; lastModifiedFabricIndex:%@; nextCredentialIndex:%@; >", NSStringFromClass([self class]), _credentialExists, _userIndex, _creatorFabricIndex, _lastModifiedFabricIndex, _nextCredentialIndex];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::DoorLock::Commands::GetCredentialStatusResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRDoorLockClusterGetCredentialStatusResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::DoorLock::Commands::GetCredentialStatusResponse::DecodableType &)decodableStruct
{
    {
        self.credentialExists = [NSNumber numberWithBool:decodableStruct.credentialExists];
    }
    {
        if (decodableStruct.userIndex.IsNull()) {
            self.userIndex = nil;
        } else {
            self.userIndex = [NSNumber numberWithUnsignedShort:decodableStruct.userIndex.Value()];
        }
    }
    {
        if (decodableStruct.creatorFabricIndex.IsNull()) {
            self.creatorFabricIndex = nil;
        } else {
            self.creatorFabricIndex = [NSNumber numberWithUnsignedChar:decodableStruct.creatorFabricIndex.Value()];
        }
    }
    {
        if (decodableStruct.lastModifiedFabricIndex.IsNull()) {
            self.lastModifiedFabricIndex = nil;
        } else {
            self.lastModifiedFabricIndex = [NSNumber numberWithUnsignedChar:decodableStruct.lastModifiedFabricIndex.Value()];
        }
    }
    {
        if (decodableStruct.nextCredentialIndex.IsNull()) {
            self.nextCredentialIndex = nil;
        } else {
            self.nextCredentialIndex = [NSNumber numberWithUnsignedShort:decodableStruct.nextCredentialIndex.Value()];
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRDoorLockClusterClearCredentialParams
- (instancetype)init
{
    if (self = [super init]) {

        _credential = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterClearCredentialParams alloc] init];

    other.credential = self.credential;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: credential:%@; >", NSStringFromClass([self class]), _credential];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterClearCredentialParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::ClearCredential::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.credential == nil) {
            encodableStruct.credential.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.credential.SetNonNull();
            nonNullValue_0.credentialType = static_cast<std::remove_reference_t<decltype(nonNullValue_0.credentialType)>>(self.credential.credentialType.unsignedCharValue);
            nonNullValue_0.credentialIndex = self.credential.credentialIndex.unsignedShortValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRDoorLockClusterUnboltDoorParams
- (instancetype)init
{
    if (self = [super init]) {

        _pinCode = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRDoorLockClusterUnboltDoorParams alloc] init];

    other.pinCode = self.pinCode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: pinCode:%@; >", NSStringFromClass([self class]), [_pinCode base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRDoorLockClusterUnboltDoorParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::DoorLock::Commands::UnboltDoor::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.pinCode != nil) {
            auto & definedValue_0 = encodableStruct.PINCode.Emplace();
            definedValue_0 = AsByteSpan(self.pinCode);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterUpOrOpenParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterUpOrOpenParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterUpOrOpenParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::UpOrOpen::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterDownOrCloseParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterDownOrCloseParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterDownOrCloseParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::DownOrClose::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterStopMotionParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterStopMotionParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterStopMotionParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::StopMotion::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterGoToLiftValueParams
- (instancetype)init
{
    if (self = [super init]) {

        _liftValue = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterGoToLiftValueParams alloc] init];

    other.liftValue = self.liftValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: liftValue:%@; >", NSStringFromClass([self class]), _liftValue];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterGoToLiftValueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::GoToLiftValue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.liftValue = self.liftValue.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterGoToLiftPercentageParams
- (instancetype)init
{
    if (self = [super init]) {

        _liftPercent100thsValue = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterGoToLiftPercentageParams alloc] init];

    other.liftPercent100thsValue = self.liftPercent100thsValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: liftPercent100thsValue:%@; >", NSStringFromClass([self class]), _liftPercent100thsValue];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterGoToLiftPercentageParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::GoToLiftPercentage::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.liftPercent100thsValue = self.liftPercent100thsValue.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterGoToTiltValueParams
- (instancetype)init
{
    if (self = [super init]) {

        _tiltValue = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterGoToTiltValueParams alloc] init];

    other.tiltValue = self.tiltValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: tiltValue:%@; >", NSStringFromClass([self class]), _tiltValue];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterGoToTiltValueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::GoToTiltValue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.tiltValue = self.tiltValue.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRWindowCoveringClusterGoToTiltPercentageParams
- (instancetype)init
{
    if (self = [super init]) {

        _tiltPercent100thsValue = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRWindowCoveringClusterGoToTiltPercentageParams alloc] init];

    other.tiltPercent100thsValue = self.tiltPercent100thsValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: tiltPercent100thsValue:%@; >", NSStringFromClass([self class]), _tiltPercent100thsValue];
    return descriptionString;
}

@end

@implementation MTRWindowCoveringClusterGoToTiltPercentageParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::WindowCovering::Commands::GoToTiltPercentage::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.tiltPercent100thsValue = self.tiltPercent100thsValue.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRBarrierControlClusterBarrierControlGoToPercentParams
- (instancetype)init
{
    if (self = [super init]) {

        _percentOpen = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRBarrierControlClusterBarrierControlGoToPercentParams alloc] init];

    other.percentOpen = self.percentOpen;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: percentOpen:%@; >", NSStringFromClass([self class]), _percentOpen];
    return descriptionString;
}

@end

@implementation MTRBarrierControlClusterBarrierControlGoToPercentParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::BarrierControl::Commands::BarrierControlGoToPercent::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.percentOpen = self.percentOpen.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRBarrierControlClusterBarrierControlStopParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRBarrierControlClusterBarrierControlStopParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRBarrierControlClusterBarrierControlStopParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::BarrierControl::Commands::BarrierControlStop::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRThermostatClusterSetpointRaiseLowerParams
- (instancetype)init
{
    if (self = [super init]) {

        _mode = @(0);

        _amount = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRThermostatClusterSetpointRaiseLowerParams alloc] init];

    other.mode = self.mode;
    other.amount = self.amount;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: mode:%@; amount:%@; >", NSStringFromClass([self class]), _mode, _amount];
    return descriptionString;
}

@end

@implementation MTRThermostatClusterSetpointRaiseLowerParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Thermostat::Commands::SetpointRaiseLower::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.mode = static_cast<std::remove_reference_t<decltype(encodableStruct.mode)>>(self.mode.unsignedCharValue);
    }
    {
        encodableStruct.amount = self.amount.charValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRThermostatClusterGetWeeklyScheduleResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _numberOfTransitionsForSequence = @(0);

        _dayOfWeekForSequence = @(0);

        _modeForSequence = @(0);

        _transitions = [NSArray array];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRThermostatClusterGetWeeklyScheduleResponseParams alloc] init];

    other.numberOfTransitionsForSequence = self.numberOfTransitionsForSequence;
    other.dayOfWeekForSequence = self.dayOfWeekForSequence;
    other.modeForSequence = self.modeForSequence;
    other.transitions = self.transitions;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: numberOfTransitionsForSequence:%@; dayOfWeekForSequence:%@; modeForSequence:%@; transitions:%@; >", NSStringFromClass([self class]), _numberOfTransitionsForSequence, _dayOfWeekForSequence, _modeForSequence, _transitions];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Thermostat::Commands::GetWeeklyScheduleResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRThermostatClusterGetWeeklyScheduleResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Thermostat::Commands::GetWeeklyScheduleResponse::DecodableType &)decodableStruct
{
    {
        self.numberOfTransitionsForSequence = [NSNumber numberWithUnsignedChar:decodableStruct.numberOfTransitionsForSequence];
    }
    {
        self.dayOfWeekForSequence = [NSNumber numberWithUnsignedChar:decodableStruct.dayOfWeekForSequence.Raw()];
    }
    {
        self.modeForSequence = [NSNumber numberWithUnsignedChar:decodableStruct.modeForSequence.Raw()];
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.transitions.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                MTRThermostatClusterThermostatScheduleTransition * newElement_0;
                newElement_0 = [MTRThermostatClusterThermostatScheduleTransition new];
                newElement_0.transitionTime = [NSNumber numberWithUnsignedShort:entry_0.transitionTime];
                if (entry_0.heatSetpoint.IsNull()) {
                    newElement_0.heatSetpoint = nil;
                } else {
                    newElement_0.heatSetpoint = [NSNumber numberWithShort:entry_0.heatSetpoint.Value()];
                }
                if (entry_0.coolSetpoint.IsNull()) {
                    newElement_0.coolSetpoint = nil;
                } else {
                    newElement_0.coolSetpoint = [NSNumber numberWithShort:entry_0.coolSetpoint.Value()];
                }
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.transitions = array_0;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRThermostatClusterSetWeeklyScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _numberOfTransitionsForSequence = @(0);

        _dayOfWeekForSequence = @(0);

        _modeForSequence = @(0);

        _transitions = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRThermostatClusterSetWeeklyScheduleParams alloc] init];

    other.numberOfTransitionsForSequence = self.numberOfTransitionsForSequence;
    other.dayOfWeekForSequence = self.dayOfWeekForSequence;
    other.modeForSequence = self.modeForSequence;
    other.transitions = self.transitions;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: numberOfTransitionsForSequence:%@; dayOfWeekForSequence:%@; modeForSequence:%@; transitions:%@; >", NSStringFromClass([self class]), _numberOfTransitionsForSequence, _dayOfWeekForSequence, _modeForSequence, _transitions];
    return descriptionString;
}

@end

@implementation MTRThermostatClusterSetWeeklyScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Thermostat::Commands::SetWeeklySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.numberOfTransitionsForSequence = self.numberOfTransitionsForSequence.unsignedCharValue;
    }
    {
        encodableStruct.dayOfWeekForSequence = static_cast<std::remove_reference_t<decltype(encodableStruct.dayOfWeekForSequence)>>(self.dayOfWeekForSequence.unsignedCharValue);
    }
    {
        encodableStruct.modeForSequence = static_cast<std::remove_reference_t<decltype(encodableStruct.modeForSequence)>>(self.modeForSequence.unsignedCharValue);
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.transitions)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.transitions.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.transitions.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.transitions.count; ++i_0) {
                    if (![self.transitions[i_0] isKindOfClass:[MTRThermostatClusterThermostatScheduleTransition class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRThermostatClusterThermostatScheduleTransition *) self.transitions[i_0];
                    listHolder_0->mList[i_0].transitionTime = element_0.transitionTime.unsignedShortValue;
                    if (element_0.heatSetpoint == nil) {
                        listHolder_0->mList[i_0].heatSetpoint.SetNull();
                    } else {
                        auto & nonNullValue_2 = listHolder_0->mList[i_0].heatSetpoint.SetNonNull();
                        nonNullValue_2 = element_0.heatSetpoint.shortValue;
                    }
                    if (element_0.coolSetpoint == nil) {
                        listHolder_0->mList[i_0].coolSetpoint.SetNull();
                    } else {
                        auto & nonNullValue_2 = listHolder_0->mList[i_0].coolSetpoint.SetNonNull();
                        nonNullValue_2 = element_0.coolSetpoint.shortValue;
                    }
                }
                encodableStruct.transitions = ListType_0(listHolder_0->mList, self.transitions.count);
            } else {
                encodableStruct.transitions = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRThermostatClusterGetWeeklyScheduleParams
- (instancetype)init
{
    if (self = [super init]) {

        _daysToReturn = @(0);

        _modeToReturn = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRThermostatClusterGetWeeklyScheduleParams alloc] init];

    other.daysToReturn = self.daysToReturn;
    other.modeToReturn = self.modeToReturn;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: daysToReturn:%@; modeToReturn:%@; >", NSStringFromClass([self class]), _daysToReturn, _modeToReturn];
    return descriptionString;
}

@end

@implementation MTRThermostatClusterGetWeeklyScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Thermostat::Commands::GetWeeklySchedule::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.daysToReturn = static_cast<std::remove_reference_t<decltype(encodableStruct.daysToReturn)>>(self.daysToReturn.unsignedCharValue);
    }
    {
        encodableStruct.modeToReturn = static_cast<std::remove_reference_t<decltype(encodableStruct.modeToReturn)>>(self.modeToReturn.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRThermostatClusterClearWeeklyScheduleParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRThermostatClusterClearWeeklyScheduleParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRThermostatClusterClearWeeklyScheduleParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Thermostat::Commands::ClearWeeklySchedule::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRFanControlClusterStepParams
- (instancetype)init
{
    if (self = [super init]) {

        _direction = @(0);

        _wrap = nil;

        _lowestOff = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRFanControlClusterStepParams alloc] init];

    other.direction = self.direction;
    other.wrap = self.wrap;
    other.lowestOff = self.lowestOff;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: direction:%@; wrap:%@; lowestOff:%@; >", NSStringFromClass([self class]), _direction, _wrap, _lowestOff];
    return descriptionString;
}

@end

@implementation MTRFanControlClusterStepParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::FanControl::Commands::Step::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.direction = static_cast<std::remove_reference_t<decltype(encodableStruct.direction)>>(self.direction.unsignedCharValue);
    }
    {
        if (self.wrap != nil) {
            auto & definedValue_0 = encodableStruct.wrap.Emplace();
            definedValue_0 = self.wrap.boolValue;
        }
    }
    {
        if (self.lowestOff != nil) {
            auto & definedValue_0 = encodableStruct.lowestOff.Emplace();
            definedValue_0 = self.lowestOff.boolValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveToHueParams
- (instancetype)init
{
    if (self = [super init]) {

        _hue = @(0);

        _direction = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveToHueParams alloc] init];

    other.hue = self.hue;
    other.direction = self.direction;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: hue:%@; direction:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _hue, _direction, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveToHueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveToHue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.hue = self.hue.unsignedCharValue;
    }
    {
        encodableStruct.direction = static_cast<std::remove_reference_t<decltype(encodableStruct.direction)>>(self.direction.unsignedCharValue);
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveHueParams
- (instancetype)init
{
    if (self = [super init]) {

        _moveMode = @(0);

        _rate = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveHueParams alloc] init];

    other.moveMode = self.moveMode;
    other.rate = self.rate;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: moveMode:%@; rate:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _moveMode, _rate, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveHueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveHue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.moveMode = static_cast<std::remove_reference_t<decltype(encodableStruct.moveMode)>>(self.moveMode.unsignedCharValue);
    }
    {
        encodableStruct.rate = self.rate.unsignedCharValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterStepHueParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepMode = @(0);

        _stepSize = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterStepHueParams alloc] init];

    other.stepMode = self.stepMode;
    other.stepSize = self.stepSize;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepMode:%@; stepSize:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepMode, _stepSize, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterStepHueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::StepHue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepMode = static_cast<std::remove_reference_t<decltype(encodableStruct.stepMode)>>(self.stepMode.unsignedCharValue);
    }
    {
        encodableStruct.stepSize = self.stepSize.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedCharValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveToSaturationParams
- (instancetype)init
{
    if (self = [super init]) {

        _saturation = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveToSaturationParams alloc] init];

    other.saturation = self.saturation;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: saturation:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _saturation, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveToSaturationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveToSaturation::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.saturation = self.saturation.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveSaturationParams
- (instancetype)init
{
    if (self = [super init]) {

        _moveMode = @(0);

        _rate = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveSaturationParams alloc] init];

    other.moveMode = self.moveMode;
    other.rate = self.rate;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: moveMode:%@; rate:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _moveMode, _rate, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveSaturationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveSaturation::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.moveMode = static_cast<std::remove_reference_t<decltype(encodableStruct.moveMode)>>(self.moveMode.unsignedCharValue);
    }
    {
        encodableStruct.rate = self.rate.unsignedCharValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterStepSaturationParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepMode = @(0);

        _stepSize = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterStepSaturationParams alloc] init];

    other.stepMode = self.stepMode;
    other.stepSize = self.stepSize;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepMode:%@; stepSize:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepMode, _stepSize, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterStepSaturationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::StepSaturation::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepMode = static_cast<std::remove_reference_t<decltype(encodableStruct.stepMode)>>(self.stepMode.unsignedCharValue);
    }
    {
        encodableStruct.stepSize = self.stepSize.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedCharValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveToHueAndSaturationParams
- (instancetype)init
{
    if (self = [super init]) {

        _hue = @(0);

        _saturation = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveToHueAndSaturationParams alloc] init];

    other.hue = self.hue;
    other.saturation = self.saturation;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: hue:%@; saturation:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _hue, _saturation, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveToHueAndSaturationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveToHueAndSaturation::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.hue = self.hue.unsignedCharValue;
    }
    {
        encodableStruct.saturation = self.saturation.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveToColorParams
- (instancetype)init
{
    if (self = [super init]) {

        _colorX = @(0);

        _colorY = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveToColorParams alloc] init];

    other.colorX = self.colorX;
    other.colorY = self.colorY;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: colorX:%@; colorY:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _colorX, _colorY, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveToColorParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveToColor::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.colorX = self.colorX.unsignedShortValue;
    }
    {
        encodableStruct.colorY = self.colorY.unsignedShortValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveColorParams
- (instancetype)init
{
    if (self = [super init]) {

        _rateX = @(0);

        _rateY = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveColorParams alloc] init];

    other.rateX = self.rateX;
    other.rateY = self.rateY;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: rateX:%@; rateY:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _rateX, _rateY, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveColorParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveColor::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.rateX = self.rateX.shortValue;
    }
    {
        encodableStruct.rateY = self.rateY.shortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterStepColorParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepX = @(0);

        _stepY = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterStepColorParams alloc] init];

    other.stepX = self.stepX;
    other.stepY = self.stepY;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepX:%@; stepY:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepX, _stepY, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterStepColorParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::StepColor::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepX = self.stepX.shortValue;
    }
    {
        encodableStruct.stepY = self.stepY.shortValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveToColorTemperatureParams
- (instancetype)init
{
    if (self = [super init]) {

        _colorTemperatureMireds = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveToColorTemperatureParams alloc] init];

    other.colorTemperatureMireds = self.colorTemperatureMireds;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: colorTemperatureMireds:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _colorTemperatureMireds, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveToColorTemperatureParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveToColorTemperature::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.colorTemperatureMireds = self.colorTemperatureMireds.unsignedShortValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveToColorTemperatureParams (Deprecated)

- (void)setColorTemperature:(NSNumber * _Nonnull)colorTemperature
{
    self.colorTemperatureMireds = colorTemperature;
}

- (NSNumber * _Nonnull)colorTemperature
{
    return self.colorTemperatureMireds;
}
@end
@implementation MTRColorControlClusterEnhancedMoveToHueParams
- (instancetype)init
{
    if (self = [super init]) {

        _enhancedHue = @(0);

        _direction = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterEnhancedMoveToHueParams alloc] init];

    other.enhancedHue = self.enhancedHue;
    other.direction = self.direction;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: enhancedHue:%@; direction:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _enhancedHue, _direction, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterEnhancedMoveToHueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::EnhancedMoveToHue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.enhancedHue = self.enhancedHue.unsignedShortValue;
    }
    {
        encodableStruct.direction = static_cast<std::remove_reference_t<decltype(encodableStruct.direction)>>(self.direction.unsignedCharValue);
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterEnhancedMoveHueParams
- (instancetype)init
{
    if (self = [super init]) {

        _moveMode = @(0);

        _rate = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterEnhancedMoveHueParams alloc] init];

    other.moveMode = self.moveMode;
    other.rate = self.rate;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: moveMode:%@; rate:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _moveMode, _rate, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterEnhancedMoveHueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::EnhancedMoveHue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.moveMode = static_cast<std::remove_reference_t<decltype(encodableStruct.moveMode)>>(self.moveMode.unsignedCharValue);
    }
    {
        encodableStruct.rate = self.rate.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterEnhancedStepHueParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepMode = @(0);

        _stepSize = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterEnhancedStepHueParams alloc] init];

    other.stepMode = self.stepMode;
    other.stepSize = self.stepSize;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepMode:%@; stepSize:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepMode, _stepSize, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterEnhancedStepHueParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::EnhancedStepHue::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepMode = static_cast<std::remove_reference_t<decltype(encodableStruct.stepMode)>>(self.stepMode.unsignedCharValue);
    }
    {
        encodableStruct.stepSize = self.stepSize.unsignedShortValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterEnhancedMoveToHueAndSaturationParams
- (instancetype)init
{
    if (self = [super init]) {

        _enhancedHue = @(0);

        _saturation = @(0);

        _transitionTime = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterEnhancedMoveToHueAndSaturationParams alloc] init];

    other.enhancedHue = self.enhancedHue;
    other.saturation = self.saturation;
    other.transitionTime = self.transitionTime;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: enhancedHue:%@; saturation:%@; transitionTime:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _enhancedHue, _saturation, _transitionTime, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterEnhancedMoveToHueAndSaturationParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::EnhancedMoveToHueAndSaturation::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.enhancedHue = self.enhancedHue.unsignedShortValue;
    }
    {
        encodableStruct.saturation = self.saturation.unsignedCharValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterColorLoopSetParams
- (instancetype)init
{
    if (self = [super init]) {

        _updateFlags = @(0);

        _action = @(0);

        _direction = @(0);

        _time = @(0);

        _startHue = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterColorLoopSetParams alloc] init];

    other.updateFlags = self.updateFlags;
    other.action = self.action;
    other.direction = self.direction;
    other.time = self.time;
    other.startHue = self.startHue;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: updateFlags:%@; action:%@; direction:%@; time:%@; startHue:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _updateFlags, _action, _direction, _time, _startHue, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterColorLoopSetParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::ColorLoopSet::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.updateFlags = static_cast<std::remove_reference_t<decltype(encodableStruct.updateFlags)>>(self.updateFlags.unsignedCharValue);
    }
    {
        encodableStruct.action = static_cast<std::remove_reference_t<decltype(encodableStruct.action)>>(self.action.unsignedCharValue);
    }
    {
        encodableStruct.direction = static_cast<std::remove_reference_t<decltype(encodableStruct.direction)>>(self.direction.unsignedCharValue);
    }
    {
        encodableStruct.time = self.time.unsignedShortValue;
    }
    {
        encodableStruct.startHue = self.startHue.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterStopMoveStepParams
- (instancetype)init
{
    if (self = [super init]) {

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterStopMoveStepParams alloc] init];

    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterStopMoveStepParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::StopMoveStep::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterMoveColorTemperatureParams
- (instancetype)init
{
    if (self = [super init]) {

        _moveMode = @(0);

        _rate = @(0);

        _colorTemperatureMinimumMireds = @(0);

        _colorTemperatureMaximumMireds = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterMoveColorTemperatureParams alloc] init];

    other.moveMode = self.moveMode;
    other.rate = self.rate;
    other.colorTemperatureMinimumMireds = self.colorTemperatureMinimumMireds;
    other.colorTemperatureMaximumMireds = self.colorTemperatureMaximumMireds;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: moveMode:%@; rate:%@; colorTemperatureMinimumMireds:%@; colorTemperatureMaximumMireds:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _moveMode, _rate, _colorTemperatureMinimumMireds, _colorTemperatureMaximumMireds, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterMoveColorTemperatureParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::MoveColorTemperature::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.moveMode = static_cast<std::remove_reference_t<decltype(encodableStruct.moveMode)>>(self.moveMode.unsignedCharValue);
    }
    {
        encodableStruct.rate = self.rate.unsignedShortValue;
    }
    {
        encodableStruct.colorTemperatureMinimumMireds = self.colorTemperatureMinimumMireds.unsignedShortValue;
    }
    {
        encodableStruct.colorTemperatureMaximumMireds = self.colorTemperatureMaximumMireds.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRColorControlClusterStepColorTemperatureParams
- (instancetype)init
{
    if (self = [super init]) {

        _stepMode = @(0);

        _stepSize = @(0);

        _transitionTime = @(0);

        _colorTemperatureMinimumMireds = @(0);

        _colorTemperatureMaximumMireds = @(0);

        _optionsMask = @(0);

        _optionsOverride = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRColorControlClusterStepColorTemperatureParams alloc] init];

    other.stepMode = self.stepMode;
    other.stepSize = self.stepSize;
    other.transitionTime = self.transitionTime;
    other.colorTemperatureMinimumMireds = self.colorTemperatureMinimumMireds;
    other.colorTemperatureMaximumMireds = self.colorTemperatureMaximumMireds;
    other.optionsMask = self.optionsMask;
    other.optionsOverride = self.optionsOverride;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: stepMode:%@; stepSize:%@; transitionTime:%@; colorTemperatureMinimumMireds:%@; colorTemperatureMaximumMireds:%@; optionsMask:%@; optionsOverride:%@; >", NSStringFromClass([self class]), _stepMode, _stepSize, _transitionTime, _colorTemperatureMinimumMireds, _colorTemperatureMaximumMireds, _optionsMask, _optionsOverride];
    return descriptionString;
}

@end

@implementation MTRColorControlClusterStepColorTemperatureParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ColorControl::Commands::StepColorTemperature::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.stepMode = static_cast<std::remove_reference_t<decltype(encodableStruct.stepMode)>>(self.stepMode.unsignedCharValue);
    }
    {
        encodableStruct.stepSize = self.stepSize.unsignedShortValue;
    }
    {
        encodableStruct.transitionTime = self.transitionTime.unsignedShortValue;
    }
    {
        encodableStruct.colorTemperatureMinimumMireds = self.colorTemperatureMinimumMireds.unsignedShortValue;
    }
    {
        encodableStruct.colorTemperatureMaximumMireds = self.colorTemperatureMaximumMireds.unsignedShortValue;
    }
    {
        encodableStruct.optionsMask = self.optionsMask.unsignedCharValue;
    }
    {
        encodableStruct.optionsOverride = self.optionsOverride.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRChannelClusterChangeChannelParams
- (instancetype)init
{
    if (self = [super init]) {

        _match = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRChannelClusterChangeChannelParams alloc] init];

    other.match = self.match;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: match:%@; >", NSStringFromClass([self class]), _match];
    return descriptionString;
}

@end

@implementation MTRChannelClusterChangeChannelParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Channel::Commands::ChangeChannel::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.match = AsCharSpan(self.match);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRChannelClusterChangeChannelResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRChannelClusterChangeChannelResponseParams alloc] init];

    other.status = self.status;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; data:%@; >", NSStringFromClass([self class]), _status, _data];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::Channel::Commands::ChangeChannelResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRChannelClusterChangeChannelResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::Channel::Commands::ChangeChannelResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.data.HasValue()) {
            self.data = AsString(decodableStruct.data.Value());
            if (self.data == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.data = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRChannelClusterChangeChannelByNumberParams
- (instancetype)init
{
    if (self = [super init]) {

        _majorNumber = @(0);

        _minorNumber = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRChannelClusterChangeChannelByNumberParams alloc] init];

    other.majorNumber = self.majorNumber;
    other.minorNumber = self.minorNumber;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: majorNumber:%@; minorNumber:%@; >", NSStringFromClass([self class]), _majorNumber, _minorNumber];
    return descriptionString;
}

@end

@implementation MTRChannelClusterChangeChannelByNumberParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Channel::Commands::ChangeChannelByNumber::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.majorNumber = self.majorNumber.unsignedShortValue;
    }
    {
        encodableStruct.minorNumber = self.minorNumber.unsignedShortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRChannelClusterSkipChannelParams
- (instancetype)init
{
    if (self = [super init]) {

        _count = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRChannelClusterSkipChannelParams alloc] init];

    other.count = self.count;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: count:%@; >", NSStringFromClass([self class]), _count];
    return descriptionString;
}

@end

@implementation MTRChannelClusterSkipChannelParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::Channel::Commands::SkipChannel::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.count = self.count.shortValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTargetNavigatorClusterNavigateTargetParams
- (instancetype)init
{
    if (self = [super init]) {

        _target = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTargetNavigatorClusterNavigateTargetParams alloc] init];

    other.target = self.target;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: target:%@; data:%@; >", NSStringFromClass([self class]), _target, _data];
    return descriptionString;
}

@end

@implementation MTRTargetNavigatorClusterNavigateTargetParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::TargetNavigator::Commands::NavigateTarget::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.target = self.target.unsignedCharValue;
    }
    {
        if (self.data != nil) {
            auto & definedValue_0 = encodableStruct.data.Emplace();
            definedValue_0 = AsCharSpan(self.data);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTargetNavigatorClusterNavigateTargetResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRTargetNavigatorClusterNavigateTargetResponseParams alloc] init];

    other.status = self.status;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; data:%@; >", NSStringFromClass([self class]), _status, _data];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::TargetNavigator::Commands::NavigateTargetResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRTargetNavigatorClusterNavigateTargetResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::TargetNavigator::Commands::NavigateTargetResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.data.HasValue()) {
            self.data = AsString(decodableStruct.data.Value());
            if (self.data == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.data = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRMediaPlaybackClusterPlayParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterPlayParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterPlayParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Play::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterPauseParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterPauseParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterPauseParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Pause::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterStopParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterStopParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterStopParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Stop::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterStopPlaybackParams

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRMediaPlaybackClusterStartOverParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterStartOverParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterStartOverParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::StartOver::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterPreviousParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterPreviousParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterPreviousParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Previous::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterNextParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterNextParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterNextParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Next::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterRewindParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterRewindParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterRewindParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Rewind::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterFastForwardParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterFastForwardParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterFastForwardParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::FastForward::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterSkipForwardParams
- (instancetype)init
{
    if (self = [super init]) {

        _deltaPositionMilliseconds = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterSkipForwardParams alloc] init];

    other.deltaPositionMilliseconds = self.deltaPositionMilliseconds;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: deltaPositionMilliseconds:%@; >", NSStringFromClass([self class]), _deltaPositionMilliseconds];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterSkipForwardParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::SkipForward::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.deltaPositionMilliseconds = self.deltaPositionMilliseconds.unsignedLongLongValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterSkipBackwardParams
- (instancetype)init
{
    if (self = [super init]) {

        _deltaPositionMilliseconds = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterSkipBackwardParams alloc] init];

    other.deltaPositionMilliseconds = self.deltaPositionMilliseconds;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: deltaPositionMilliseconds:%@; >", NSStringFromClass([self class]), _deltaPositionMilliseconds];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterSkipBackwardParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::SkipBackward::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.deltaPositionMilliseconds = self.deltaPositionMilliseconds.unsignedLongLongValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaPlaybackClusterPlaybackResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterPlaybackResponseParams alloc] init];

    other.status = self.status;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; data:%@; >", NSStringFromClass([self class]), _status, _data];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::MediaPlayback::Commands::PlaybackResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRMediaPlaybackClusterPlaybackResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::MediaPlayback::Commands::PlaybackResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.data.HasValue()) {
            self.data = AsString(decodableStruct.data.Value());
            if (self.data == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.data = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRMediaPlaybackClusterSeekParams
- (instancetype)init
{
    if (self = [super init]) {

        _position = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaPlaybackClusterSeekParams alloc] init];

    other.position = self.position;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: position:%@; >", NSStringFromClass([self class]), _position];
    return descriptionString;
}

@end

@implementation MTRMediaPlaybackClusterSeekParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaPlayback::Commands::Seek::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.position = self.position.unsignedLongLongValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaInputClusterSelectInputParams
- (instancetype)init
{
    if (self = [super init]) {

        _index = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaInputClusterSelectInputParams alloc] init];

    other.index = self.index;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: index:%@; >", NSStringFromClass([self class]), _index];
    return descriptionString;
}

@end

@implementation MTRMediaInputClusterSelectInputParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaInput::Commands::SelectInput::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.index = self.index.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaInputClusterShowInputStatusParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaInputClusterShowInputStatusParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaInputClusterShowInputStatusParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaInput::Commands::ShowInputStatus::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaInputClusterHideInputStatusParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaInputClusterHideInputStatusParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRMediaInputClusterHideInputStatusParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaInput::Commands::HideInputStatus::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRMediaInputClusterRenameInputParams
- (instancetype)init
{
    if (self = [super init]) {

        _index = @(0);

        _name = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRMediaInputClusterRenameInputParams alloc] init];

    other.index = self.index;
    other.name = self.name;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: index:%@; name:%@; >", NSStringFromClass([self class]), _index, _name];
    return descriptionString;
}

@end

@implementation MTRMediaInputClusterRenameInputParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::MediaInput::Commands::RenameInput::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.index = self.index.unsignedCharValue;
    }
    {
        encodableStruct.name = AsCharSpan(self.name);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRLowPowerClusterSleepParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRLowPowerClusterSleepParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRLowPowerClusterSleepParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::LowPower::Commands::Sleep::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRKeypadInputClusterSendKeyParams
- (instancetype)init
{
    if (self = [super init]) {

        _keyCode = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRKeypadInputClusterSendKeyParams alloc] init];

    other.keyCode = self.keyCode;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: keyCode:%@; >", NSStringFromClass([self class]), _keyCode];
    return descriptionString;
}

@end

@implementation MTRKeypadInputClusterSendKeyParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::KeypadInput::Commands::SendKey::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.keyCode = static_cast<std::remove_reference_t<decltype(encodableStruct.keyCode)>>(self.keyCode.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRKeypadInputClusterSendKeyResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRKeypadInputClusterSendKeyResponseParams alloc] init];

    other.status = self.status;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; >", NSStringFromClass([self class]), _status];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::KeypadInput::Commands::SendKeyResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRKeypadInputClusterSendKeyResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::KeypadInput::Commands::SendKeyResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRContentLauncherClusterLaunchContentParams
- (instancetype)init
{
    if (self = [super init]) {

        _search = [MTRContentLauncherClusterContentSearchStruct new];

        _autoPlay = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRContentLauncherClusterLaunchContentParams alloc] init];

    other.search = self.search;
    other.autoPlay = self.autoPlay;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: search:%@; autoPlay:%@; data:%@; >", NSStringFromClass([self class]), _search, _autoPlay, _data];
    return descriptionString;
}

@end

@implementation MTRContentLauncherClusterLaunchContentParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ContentLauncher::Commands::LaunchContent::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_1 = std::remove_reference_t<decltype(encodableStruct.search.parameterList)>;
            using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
            if (self.search.parameterList.count != 0) {
                auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.search.parameterList.count);
                if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_1);
                for (size_t i_1 = 0; i_1 < self.search.parameterList.count; ++i_1) {
                    if (![self.search.parameterList[i_1] isKindOfClass:[MTRContentLauncherClusterParameterStruct class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_1 = (MTRContentLauncherClusterParameterStruct *) self.search.parameterList[i_1];
                    listHolder_1->mList[i_1].type = static_cast<std::remove_reference_t<decltype(listHolder_1->mList[i_1].type)>>(element_1.type.unsignedCharValue);
                    listHolder_1->mList[i_1].value = AsCharSpan(element_1.value);
                    if (element_1.externalIDList != nil) {
                        auto & definedValue_3 = listHolder_1->mList[i_1].externalIDList.Emplace();
                        {
                            using ListType_4 = std::remove_reference_t<decltype(definedValue_3)>;
                            using ListMemberType_4 = ListMemberTypeGetter<ListType_4>::Type;
                            if (element_1.externalIDList.count != 0) {
                                auto * listHolder_4 = new ListHolder<ListMemberType_4>(element_1.externalIDList.count);
                                if (listHolder_4 == nullptr || listHolder_4->mList == nullptr) {
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                listFreer.add(listHolder_4);
                                for (size_t i_4 = 0; i_4 < element_1.externalIDList.count; ++i_4) {
                                    if (![element_1.externalIDList[i_4] isKindOfClass:[MTRContentLauncherClusterAdditionalInfoStruct class]]) {
                                        // Wrong kind of value.
                                        return CHIP_ERROR_INVALID_ARGUMENT;
                                    }
                                    auto element_4 = (MTRContentLauncherClusterAdditionalInfoStruct *) element_1.externalIDList[i_4];
                                    listHolder_4->mList[i_4].name = AsCharSpan(element_4.name);
                                    listHolder_4->mList[i_4].value = AsCharSpan(element_4.value);
                                }
                                definedValue_3 = ListType_4(listHolder_4->mList, element_1.externalIDList.count);
                            } else {
                                definedValue_3 = ListType_4();
                            }
                        }
                    }
                }
                encodableStruct.search.parameterList = ListType_1(listHolder_1->mList, self.search.parameterList.count);
            } else {
                encodableStruct.search.parameterList = ListType_1();
            }
        }
    }
    {
        encodableStruct.autoPlay = self.autoPlay.boolValue;
    }
    {
        if (self.data != nil) {
            auto & definedValue_0 = encodableStruct.data.Emplace();
            definedValue_0 = AsCharSpan(self.data);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRContentLauncherClusterLaunchURLParams
- (instancetype)init
{
    if (self = [super init]) {

        _contentURL = @"";

        _displayString = nil;

        _brandingInformation = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRContentLauncherClusterLaunchURLParams alloc] init];

    other.contentURL = self.contentURL;
    other.displayString = self.displayString;
    other.brandingInformation = self.brandingInformation;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: contentURL:%@; displayString:%@; brandingInformation:%@; >", NSStringFromClass([self class]), _contentURL, _displayString, _brandingInformation];
    return descriptionString;
}

@end

@implementation MTRContentLauncherClusterLaunchURLParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ContentLauncher::Commands::LaunchURL::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.contentURL = AsCharSpan(self.contentURL);
    }
    {
        if (self.displayString != nil) {
            auto & definedValue_0 = encodableStruct.displayString.Emplace();
            definedValue_0 = AsCharSpan(self.displayString);
        }
    }
    {
        if (self.brandingInformation != nil) {
            auto & definedValue_0 = encodableStruct.brandingInformation.Emplace();
            definedValue_0.providerName = AsCharSpan(self.brandingInformation.providerName);
            if (self.brandingInformation.background != nil) {
                auto & definedValue_2 = definedValue_0.background.Emplace();
                if (self.brandingInformation.background.imageURL != nil) {
                    auto & definedValue_4 = definedValue_2.imageURL.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.background.imageURL);
                }
                if (self.brandingInformation.background.color != nil) {
                    auto & definedValue_4 = definedValue_2.color.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.background.color);
                }
                if (self.brandingInformation.background.size != nil) {
                    auto & definedValue_4 = definedValue_2.size.Emplace();
                    definedValue_4.width = self.brandingInformation.background.size.width.doubleValue;
                    definedValue_4.height = self.brandingInformation.background.size.height.doubleValue;
                    definedValue_4.metric = static_cast<std::remove_reference_t<decltype(definedValue_4.metric)>>(self.brandingInformation.background.size.metric.unsignedCharValue);
                }
            }
            if (self.brandingInformation.logo != nil) {
                auto & definedValue_2 = definedValue_0.logo.Emplace();
                if (self.brandingInformation.logo.imageURL != nil) {
                    auto & definedValue_4 = definedValue_2.imageURL.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.logo.imageURL);
                }
                if (self.brandingInformation.logo.color != nil) {
                    auto & definedValue_4 = definedValue_2.color.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.logo.color);
                }
                if (self.brandingInformation.logo.size != nil) {
                    auto & definedValue_4 = definedValue_2.size.Emplace();
                    definedValue_4.width = self.brandingInformation.logo.size.width.doubleValue;
                    definedValue_4.height = self.brandingInformation.logo.size.height.doubleValue;
                    definedValue_4.metric = static_cast<std::remove_reference_t<decltype(definedValue_4.metric)>>(self.brandingInformation.logo.size.metric.unsignedCharValue);
                }
            }
            if (self.brandingInformation.progressBar != nil) {
                auto & definedValue_2 = definedValue_0.progressBar.Emplace();
                if (self.brandingInformation.progressBar.imageURL != nil) {
                    auto & definedValue_4 = definedValue_2.imageURL.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.progressBar.imageURL);
                }
                if (self.brandingInformation.progressBar.color != nil) {
                    auto & definedValue_4 = definedValue_2.color.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.progressBar.color);
                }
                if (self.brandingInformation.progressBar.size != nil) {
                    auto & definedValue_4 = definedValue_2.size.Emplace();
                    definedValue_4.width = self.brandingInformation.progressBar.size.width.doubleValue;
                    definedValue_4.height = self.brandingInformation.progressBar.size.height.doubleValue;
                    definedValue_4.metric = static_cast<std::remove_reference_t<decltype(definedValue_4.metric)>>(self.brandingInformation.progressBar.size.metric.unsignedCharValue);
                }
            }
            if (self.brandingInformation.splash != nil) {
                auto & definedValue_2 = definedValue_0.splash.Emplace();
                if (self.brandingInformation.splash.imageURL != nil) {
                    auto & definedValue_4 = definedValue_2.imageURL.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.splash.imageURL);
                }
                if (self.brandingInformation.splash.color != nil) {
                    auto & definedValue_4 = definedValue_2.color.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.splash.color);
                }
                if (self.brandingInformation.splash.size != nil) {
                    auto & definedValue_4 = definedValue_2.size.Emplace();
                    definedValue_4.width = self.brandingInformation.splash.size.width.doubleValue;
                    definedValue_4.height = self.brandingInformation.splash.size.height.doubleValue;
                    definedValue_4.metric = static_cast<std::remove_reference_t<decltype(definedValue_4.metric)>>(self.brandingInformation.splash.size.metric.unsignedCharValue);
                }
            }
            if (self.brandingInformation.waterMark != nil) {
                auto & definedValue_2 = definedValue_0.waterMark.Emplace();
                if (self.brandingInformation.waterMark.imageURL != nil) {
                    auto & definedValue_4 = definedValue_2.imageURL.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.waterMark.imageURL);
                }
                if (self.brandingInformation.waterMark.color != nil) {
                    auto & definedValue_4 = definedValue_2.color.Emplace();
                    definedValue_4 = AsCharSpan(self.brandingInformation.waterMark.color);
                }
                if (self.brandingInformation.waterMark.size != nil) {
                    auto & definedValue_4 = definedValue_2.size.Emplace();
                    definedValue_4.width = self.brandingInformation.waterMark.size.width.doubleValue;
                    definedValue_4.height = self.brandingInformation.waterMark.size.height.doubleValue;
                    definedValue_4.metric = static_cast<std::remove_reference_t<decltype(definedValue_4.metric)>>(self.brandingInformation.waterMark.size.metric.unsignedCharValue);
                }
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRContentLauncherClusterLauncherResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRContentLauncherClusterLauncherResponseParams alloc] init];

    other.status = self.status;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; data:%@; >", NSStringFromClass([self class]), _status, _data];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::ContentLauncher::Commands::LauncherResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRContentLauncherClusterLauncherResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::ContentLauncher::Commands::LauncherResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.data.HasValue()) {
            self.data = AsString(decodableStruct.data.Value());
            if (self.data == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.data = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRContentLauncherClusterLaunchResponseParams
@dynamic status;
@dynamic data;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRAudioOutputClusterSelectOutputParams
- (instancetype)init
{
    if (self = [super init]) {

        _index = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAudioOutputClusterSelectOutputParams alloc] init];

    other.index = self.index;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: index:%@; >", NSStringFromClass([self class]), _index];
    return descriptionString;
}

@end

@implementation MTRAudioOutputClusterSelectOutputParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AudioOutput::Commands::SelectOutput::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.index = self.index.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRAudioOutputClusterRenameOutputParams
- (instancetype)init
{
    if (self = [super init]) {

        _index = @(0);

        _name = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAudioOutputClusterRenameOutputParams alloc] init];

    other.index = self.index;
    other.name = self.name;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: index:%@; name:%@; >", NSStringFromClass([self class]), _index, _name];
    return descriptionString;
}

@end

@implementation MTRAudioOutputClusterRenameOutputParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AudioOutput::Commands::RenameOutput::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.index = self.index.unsignedCharValue;
    }
    {
        encodableStruct.name = AsCharSpan(self.name);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRApplicationLauncherClusterLaunchAppParams
- (instancetype)init
{
    if (self = [super init]) {

        _application = nil;

        _data = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRApplicationLauncherClusterLaunchAppParams alloc] init];

    other.application = self.application;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: application:%@; data:%@; >", NSStringFromClass([self class]), _application, [_data base64EncodedStringWithOptions:0]];
    return descriptionString;
}

@end

@implementation MTRApplicationLauncherClusterLaunchAppParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ApplicationLauncher::Commands::LaunchApp::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.application != nil) {
            auto & definedValue_0 = encodableStruct.application.Emplace();
            definedValue_0.catalogVendorID = self.application.catalogVendorID.unsignedShortValue;
            definedValue_0.applicationID = AsCharSpan(self.application.applicationID);
        }
    }
    {
        if (self.data != nil) {
            auto & definedValue_0 = encodableStruct.data.Emplace();
            definedValue_0 = AsByteSpan(self.data);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRApplicationLauncherClusterStopAppParams
- (instancetype)init
{
    if (self = [super init]) {

        _application = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRApplicationLauncherClusterStopAppParams alloc] init];

    other.application = self.application;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: application:%@; >", NSStringFromClass([self class]), _application];
    return descriptionString;
}

@end

@implementation MTRApplicationLauncherClusterStopAppParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ApplicationLauncher::Commands::StopApp::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.application != nil) {
            auto & definedValue_0 = encodableStruct.application.Emplace();
            definedValue_0.catalogVendorID = self.application.catalogVendorID.unsignedShortValue;
            definedValue_0.applicationID = AsCharSpan(self.application.applicationID);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRApplicationLauncherClusterHideAppParams
- (instancetype)init
{
    if (self = [super init]) {

        _application = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRApplicationLauncherClusterHideAppParams alloc] init];

    other.application = self.application;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: application:%@; >", NSStringFromClass([self class]), _application];
    return descriptionString;
}

@end

@implementation MTRApplicationLauncherClusterHideAppParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ApplicationLauncher::Commands::HideApp::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.application != nil) {
            auto & definedValue_0 = encodableStruct.application.Emplace();
            definedValue_0.catalogVendorID = self.application.catalogVendorID.unsignedShortValue;
            definedValue_0.applicationID = AsCharSpan(self.application.applicationID);
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRApplicationLauncherClusterLauncherResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _status = @(0);

        _data = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRApplicationLauncherClusterLauncherResponseParams alloc] init];

    other.status = self.status;
    other.data = self.data;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: status:%@; data:%@; >", NSStringFromClass([self class]), _status, [_data base64EncodedStringWithOptions:0]];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::ApplicationLauncher::Commands::LauncherResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRApplicationLauncherClusterLauncherResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::ApplicationLauncher::Commands::LauncherResponse::DecodableType &)decodableStruct
{
    {
        self.status = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.status)];
    }
    {
        if (decodableStruct.data.HasValue()) {
            self.data = AsData(decodableStruct.data.Value());
        } else {
            self.data = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRAccountLoginClusterGetSetupPINParams
- (instancetype)init
{
    if (self = [super init]) {

        _tempAccountIdentifier = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAccountLoginClusterGetSetupPINParams alloc] init];

    other.tempAccountIdentifier = self.tempAccountIdentifier;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: tempAccountIdentifier:%@; >", NSStringFromClass([self class]), _tempAccountIdentifier];
    return descriptionString;
}

@end

@implementation MTRAccountLoginClusterGetSetupPINParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AccountLogin::Commands::GetSetupPIN::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.tempAccountIdentifier = AsCharSpan(self.tempAccountIdentifier);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRAccountLoginClusterGetSetupPINResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _setupPIN = @"";
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAccountLoginClusterGetSetupPINResponseParams alloc] init];

    other.setupPIN = self.setupPIN;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: setupPIN:%@; >", NSStringFromClass([self class]), _setupPIN];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::AccountLogin::Commands::GetSetupPINResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRAccountLoginClusterGetSetupPINResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::AccountLogin::Commands::GetSetupPINResponse::DecodableType &)decodableStruct
{
    {
        self.setupPIN = AsString(decodableStruct.setupPIN);
        if (self.setupPIN == nil) {
            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
            return err;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRAccountLoginClusterLoginParams
- (instancetype)init
{
    if (self = [super init]) {

        _tempAccountIdentifier = @"";

        _setupPIN = @"";
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAccountLoginClusterLoginParams alloc] init];

    other.tempAccountIdentifier = self.tempAccountIdentifier;
    other.setupPIN = self.setupPIN;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: tempAccountIdentifier:%@; setupPIN:%@; >", NSStringFromClass([self class]), _tempAccountIdentifier, _setupPIN];
    return descriptionString;
}

@end

@implementation MTRAccountLoginClusterLoginParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AccountLogin::Commands::Login::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.tempAccountIdentifier = AsCharSpan(self.tempAccountIdentifier);
    }
    {
        encodableStruct.setupPIN = AsCharSpan(self.setupPIN);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRAccountLoginClusterLogoutParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRAccountLoginClusterLogoutParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRAccountLoginClusterLogoutParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::AccountLogin::Commands::Logout::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRElectricalMeasurementClusterGetProfileInfoResponseCommandParams
- (instancetype)init
{
    if (self = [super init]) {

        _profileCount = @(0);

        _profileIntervalPeriod = @(0);

        _maxNumberOfIntervals = @(0);

        _listOfAttributes = [NSArray array];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRElectricalMeasurementClusterGetProfileInfoResponseCommandParams alloc] init];

    other.profileCount = self.profileCount;
    other.profileIntervalPeriod = self.profileIntervalPeriod;
    other.maxNumberOfIntervals = self.maxNumberOfIntervals;
    other.listOfAttributes = self.listOfAttributes;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: profileCount:%@; profileIntervalPeriod:%@; maxNumberOfIntervals:%@; listOfAttributes:%@; >", NSStringFromClass([self class]), _profileCount, _profileIntervalPeriod, _maxNumberOfIntervals, _listOfAttributes];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::ElectricalMeasurement::Commands::GetProfileInfoResponseCommand::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRElectricalMeasurementClusterGetProfileInfoResponseCommandParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::ElectricalMeasurement::Commands::GetProfileInfoResponseCommand::DecodableType &)decodableStruct
{
    {
        self.profileCount = [NSNumber numberWithUnsignedChar:decodableStruct.profileCount];
    }
    {
        self.profileIntervalPeriod = [NSNumber numberWithUnsignedChar:decodableStruct.profileIntervalPeriod];
    }
    {
        self.maxNumberOfIntervals = [NSNumber numberWithUnsignedChar:decodableStruct.maxNumberOfIntervals];
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.listOfAttributes.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithUnsignedShort:entry_0];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.listOfAttributes = array_0;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRElectricalMeasurementClusterGetProfileInfoCommandParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRElectricalMeasurementClusterGetProfileInfoCommandParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRElectricalMeasurementClusterGetProfileInfoCommandParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ElectricalMeasurement::Commands::GetProfileInfoCommand::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRElectricalMeasurementClusterGetMeasurementProfileResponseCommandParams
- (instancetype)init
{
    if (self = [super init]) {

        _startTime = @(0);

        _status = @(0);

        _profileIntervalPeriod = @(0);

        _numberOfIntervalsDelivered = @(0);

        _attributeId = @(0);

        _intervals = [NSArray array];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRElectricalMeasurementClusterGetMeasurementProfileResponseCommandParams alloc] init];

    other.startTime = self.startTime;
    other.status = self.status;
    other.profileIntervalPeriod = self.profileIntervalPeriod;
    other.numberOfIntervalsDelivered = self.numberOfIntervalsDelivered;
    other.attributeId = self.attributeId;
    other.intervals = self.intervals;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: startTime:%@; status:%@; profileIntervalPeriod:%@; numberOfIntervalsDelivered:%@; attributeId:%@; intervals:%@; >", NSStringFromClass([self class]), _startTime, _status, _profileIntervalPeriod, _numberOfIntervalsDelivered, _attributeId, _intervals];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::ElectricalMeasurement::Commands::GetMeasurementProfileResponseCommand::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRElectricalMeasurementClusterGetMeasurementProfileResponseCommandParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::ElectricalMeasurement::Commands::GetMeasurementProfileResponseCommand::DecodableType &)decodableStruct
{
    {
        self.startTime = [NSNumber numberWithUnsignedInt:decodableStruct.startTime];
    }
    {
        self.status = [NSNumber numberWithUnsignedChar:decodableStruct.status];
    }
    {
        self.profileIntervalPeriod = [NSNumber numberWithUnsignedChar:decodableStruct.profileIntervalPeriod];
    }
    {
        self.numberOfIntervalsDelivered = [NSNumber numberWithUnsignedChar:decodableStruct.numberOfIntervalsDelivered];
    }
    {
        self.attributeId = [NSNumber numberWithUnsignedShort:decodableStruct.attributeId];
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.intervals.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithUnsignedChar:entry_0];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.intervals = array_0;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRElectricalMeasurementClusterGetMeasurementProfileCommandParams
- (instancetype)init
{
    if (self = [super init]) {

        _attributeId = @(0);

        _startTime = @(0);

        _numberOfIntervals = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRElectricalMeasurementClusterGetMeasurementProfileCommandParams alloc] init];

    other.attributeId = self.attributeId;
    other.startTime = self.startTime;
    other.numberOfIntervals = self.numberOfIntervals;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: attributeId:%@; startTime:%@; numberOfIntervals:%@; >", NSStringFromClass([self class]), _attributeId, _startTime, _numberOfIntervals];
    return descriptionString;
}

@end

@implementation MTRElectricalMeasurementClusterGetMeasurementProfileCommandParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::ElectricalMeasurement::Commands::GetMeasurementProfileCommand::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.attributeId = self.attributeId.unsignedShortValue;
    }
    {
        encodableStruct.startTime = self.startTime.unsignedIntValue;
    }
    {
        encodableStruct.numberOfIntervals = self.numberOfIntervals.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRUnitTestingClusterTestParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::Test::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestParams

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestSpecificResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _returnValue = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestSpecificResponseParams alloc] init];

    other.returnValue = self.returnValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: returnValue:%@; >", NSStringFromClass([self class]), _returnValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestSpecificResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestSpecificResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestSpecificResponse::DecodableType &)decodableStruct
{
    {
        self.returnValue = [NSNumber numberWithUnsignedChar:decodableStruct.returnValue];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestSpecificResponseParams
@dynamic returnValue;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestNotHandledParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestNotHandledParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestNotHandledParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestNotHandled::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestNotHandledParams

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestAddArgumentsResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _returnValue = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestAddArgumentsResponseParams alloc] init];

    other.returnValue = self.returnValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: returnValue:%@; >", NSStringFromClass([self class]), _returnValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestAddArgumentsResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestAddArgumentsResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestAddArgumentsResponse::DecodableType &)decodableStruct
{
    {
        self.returnValue = [NSNumber numberWithUnsignedChar:decodableStruct.returnValue];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestAddArgumentsResponseParams
@dynamic returnValue;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestSpecificParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestSpecificParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestSpecificParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestSpecific::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestSpecificParams

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestSimpleArgumentResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _returnValue = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestSimpleArgumentResponseParams alloc] init];

    other.returnValue = self.returnValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: returnValue:%@; >", NSStringFromClass([self class]), _returnValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestSimpleArgumentResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestSimpleArgumentResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestSimpleArgumentResponse::DecodableType &)decodableStruct
{
    {
        self.returnValue = [NSNumber numberWithBool:decodableStruct.returnValue];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestSimpleArgumentResponseParams
@dynamic returnValue;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestUnknownCommandParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestUnknownCommandParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestUnknownCommandParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestUnknownCommand::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestUnknownCommandParams

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestStructArrayArgumentResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];

        _arg2 = [NSArray array];

        _arg3 = [NSArray array];

        _arg4 = [NSArray array];

        _arg5 = @(0);

        _arg6 = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestStructArrayArgumentResponseParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.arg3 = self.arg3;
    other.arg4 = self.arg4;
    other.arg5 = self.arg5;
    other.arg6 = self.arg6;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; arg3:%@; arg4:%@; arg5:%@; arg6:%@; >", NSStringFromClass([self class]), _arg1, _arg2, _arg3, _arg4, _arg5, _arg6];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestStructArrayArgumentResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestStructArrayArgumentResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestStructArrayArgumentResponse::DecodableType &)decodableStruct
{
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.arg1.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                MTRUnitTestingClusterNestedStructList * newElement_0;
                newElement_0 = [MTRUnitTestingClusterNestedStructList new];
                newElement_0.a = [NSNumber numberWithUnsignedChar:entry_0.a];
                newElement_0.b = [NSNumber numberWithBool:entry_0.b];
                newElement_0.c = [MTRUnitTestingClusterSimpleStruct new];
                newElement_0.c.a = [NSNumber numberWithUnsignedChar:entry_0.c.a];
                newElement_0.c.b = [NSNumber numberWithBool:entry_0.c.b];
                newElement_0.c.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_0.c.c)];
                newElement_0.c.d = AsData(entry_0.c.d);
                newElement_0.c.e = AsString(entry_0.c.e);
                if (newElement_0.c.e == nil) {
                    CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                    return err;
                }
                newElement_0.c.f = [NSNumber numberWithUnsignedChar:entry_0.c.f.Raw()];
                newElement_0.c.g = [NSNumber numberWithFloat:entry_0.c.g];
                newElement_0.c.h = [NSNumber numberWithDouble:entry_0.c.h];
                { // Scope for our temporary variables
                    auto * array_2 = [NSMutableArray new];
                    auto iter_2 = entry_0.d.begin();
                    while (iter_2.Next()) {
                        auto & entry_2 = iter_2.GetValue();
                        MTRUnitTestingClusterSimpleStruct * newElement_2;
                        newElement_2 = [MTRUnitTestingClusterSimpleStruct new];
                        newElement_2.a = [NSNumber numberWithUnsignedChar:entry_2.a];
                        newElement_2.b = [NSNumber numberWithBool:entry_2.b];
                        newElement_2.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_2.c)];
                        newElement_2.d = AsData(entry_2.d);
                        newElement_2.e = AsString(entry_2.e);
                        if (newElement_2.e == nil) {
                            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                            return err;
                        }
                        newElement_2.f = [NSNumber numberWithUnsignedChar:entry_2.f.Raw()];
                        newElement_2.g = [NSNumber numberWithFloat:entry_2.g];
                        newElement_2.h = [NSNumber numberWithDouble:entry_2.h];
                        [array_2 addObject:newElement_2];
                    }
                    CHIP_ERROR err = iter_2.GetStatus();
                    if (err != CHIP_NO_ERROR) {
                        return err;
                    }
                    newElement_0.d = array_2;
                }
                { // Scope for our temporary variables
                    auto * array_2 = [NSMutableArray new];
                    auto iter_2 = entry_0.e.begin();
                    while (iter_2.Next()) {
                        auto & entry_2 = iter_2.GetValue();
                        NSNumber * newElement_2;
                        newElement_2 = [NSNumber numberWithUnsignedInt:entry_2];
                        [array_2 addObject:newElement_2];
                    }
                    CHIP_ERROR err = iter_2.GetStatus();
                    if (err != CHIP_NO_ERROR) {
                        return err;
                    }
                    newElement_0.e = array_2;
                }
                { // Scope for our temporary variables
                    auto * array_2 = [NSMutableArray new];
                    auto iter_2 = entry_0.f.begin();
                    while (iter_2.Next()) {
                        auto & entry_2 = iter_2.GetValue();
                        NSData * newElement_2;
                        newElement_2 = AsData(entry_2);
                        [array_2 addObject:newElement_2];
                    }
                    CHIP_ERROR err = iter_2.GetStatus();
                    if (err != CHIP_NO_ERROR) {
                        return err;
                    }
                    newElement_0.f = array_2;
                }
                { // Scope for our temporary variables
                    auto * array_2 = [NSMutableArray new];
                    auto iter_2 = entry_0.g.begin();
                    while (iter_2.Next()) {
                        auto & entry_2 = iter_2.GetValue();
                        NSNumber * newElement_2;
                        newElement_2 = [NSNumber numberWithUnsignedChar:entry_2];
                        [array_2 addObject:newElement_2];
                    }
                    CHIP_ERROR err = iter_2.GetStatus();
                    if (err != CHIP_NO_ERROR) {
                        return err;
                    }
                    newElement_0.g = array_2;
                }
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.arg1 = array_0;
        }
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.arg2.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                MTRUnitTestingClusterSimpleStruct * newElement_0;
                newElement_0 = [MTRUnitTestingClusterSimpleStruct new];
                newElement_0.a = [NSNumber numberWithUnsignedChar:entry_0.a];
                newElement_0.b = [NSNumber numberWithBool:entry_0.b];
                newElement_0.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_0.c)];
                newElement_0.d = AsData(entry_0.d);
                newElement_0.e = AsString(entry_0.e);
                if (newElement_0.e == nil) {
                    CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                    return err;
                }
                newElement_0.f = [NSNumber numberWithUnsignedChar:entry_0.f.Raw()];
                newElement_0.g = [NSNumber numberWithFloat:entry_0.g];
                newElement_0.h = [NSNumber numberWithDouble:entry_0.h];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.arg2 = array_0;
        }
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.arg3.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_0)];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.arg3 = array_0;
        }
    }
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.arg4.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithBool:entry_0];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.arg4 = array_0;
        }
    }
    {
        self.arg5 = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.arg5)];
    }
    {
        self.arg6 = [NSNumber numberWithBool:decodableStruct.arg6];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestStructArrayArgumentResponseParams
@dynamic arg1;
@dynamic arg2;
@dynamic arg3;
@dynamic arg4;
@dynamic arg5;
@dynamic arg6;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestAddArgumentsParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);

        _arg2 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestAddArgumentsParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; >", NSStringFromClass([self class]), _arg1, _arg2];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestAddArgumentsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestAddArguments::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1 = self.arg1.unsignedCharValue;
    }
    {
        encodableStruct.arg2 = self.arg2.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestAddArgumentsParams
@dynamic arg1;
@dynamic arg2;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestListInt8UReverseResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestListInt8UReverseResponseParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestListInt8UReverseResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestListInt8UReverseResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestListInt8UReverseResponse::DecodableType &)decodableStruct
{
    {
        { // Scope for our temporary variables
            auto * array_0 = [NSMutableArray new];
            auto iter_0 = decodableStruct.arg1.begin();
            while (iter_0.Next()) {
                auto & entry_0 = iter_0.GetValue();
                NSNumber * newElement_0;
                newElement_0 = [NSNumber numberWithUnsignedChar:entry_0];
                [array_0 addObject:newElement_0];
            }
            CHIP_ERROR err = iter_0.GetStatus();
            if (err != CHIP_NO_ERROR) {
                return err;
            }
            self.arg1 = array_0;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestListInt8UReverseResponseParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestSimpleArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestSimpleArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestSimpleArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestSimpleArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1 = self.arg1.boolValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestSimpleArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestEnumsResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);

        _arg2 = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestEnumsResponseParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; >", NSStringFromClass([self class]), _arg1, _arg2];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestEnumsResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestEnumsResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestEnumsResponse::DecodableType &)decodableStruct
{
    {
        self.arg1 = [NSNumber numberWithUnsignedShort:chip::to_underlying(decodableStruct.arg1)];
    }
    {
        self.arg2 = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.arg2)];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestEnumsResponseParams
@dynamic arg1;
@dynamic arg2;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestStructArrayArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];

        _arg2 = [NSArray array];

        _arg3 = [NSArray array];

        _arg4 = [NSArray array];

        _arg5 = @(0);

        _arg6 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestStructArrayArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.arg3 = self.arg3;
    other.arg4 = self.arg4;
    other.arg5 = self.arg5;
    other.arg6 = self.arg6;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; arg3:%@; arg4:%@; arg5:%@; arg6:%@; >", NSStringFromClass([self class]), _arg1, _arg2, _arg3, _arg4, _arg5, _arg6];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestStructArrayArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestStructArrayArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg1)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg1.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg1.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg1.count; ++i_0) {
                    if (![self.arg1[i_0] isKindOfClass:[MTRUnitTestingClusterNestedStructList class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRUnitTestingClusterNestedStructList *) self.arg1[i_0];
                    listHolder_0->mList[i_0].a = element_0.a.unsignedCharValue;
                    listHolder_0->mList[i_0].b = element_0.b.boolValue;
                    listHolder_0->mList[i_0].c.a = element_0.c.a.unsignedCharValue;
                    listHolder_0->mList[i_0].c.b = element_0.c.b.boolValue;
                    listHolder_0->mList[i_0].c.c = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].c.c)>>(element_0.c.c.unsignedCharValue);
                    listHolder_0->mList[i_0].c.d = AsByteSpan(element_0.c.d);
                    listHolder_0->mList[i_0].c.e = AsCharSpan(element_0.c.e);
                    listHolder_0->mList[i_0].c.f = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].c.f)>>(element_0.c.f.unsignedCharValue);
                    listHolder_0->mList[i_0].c.g = element_0.c.g.floatValue;
                    listHolder_0->mList[i_0].c.h = element_0.c.h.doubleValue;
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].d)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.d.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.d.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.d.count; ++i_2) {
                                if (![element_0.d[i_2] isKindOfClass:[MTRUnitTestingClusterSimpleStruct class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (MTRUnitTestingClusterSimpleStruct *) element_0.d[i_2];
                                listHolder_2->mList[i_2].a = element_2.a.unsignedCharValue;
                                listHolder_2->mList[i_2].b = element_2.b.boolValue;
                                listHolder_2->mList[i_2].c = static_cast<std::remove_reference_t<decltype(listHolder_2->mList[i_2].c)>>(element_2.c.unsignedCharValue);
                                listHolder_2->mList[i_2].d = AsByteSpan(element_2.d);
                                listHolder_2->mList[i_2].e = AsCharSpan(element_2.e);
                                listHolder_2->mList[i_2].f = static_cast<std::remove_reference_t<decltype(listHolder_2->mList[i_2].f)>>(element_2.f.unsignedCharValue);
                                listHolder_2->mList[i_2].g = element_2.g.floatValue;
                                listHolder_2->mList[i_2].h = element_2.h.doubleValue;
                            }
                            listHolder_0->mList[i_0].d = ListType_2(listHolder_2->mList, element_0.d.count);
                        } else {
                            listHolder_0->mList[i_0].d = ListType_2();
                        }
                    }
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].e)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.e.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.e.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.e.count; ++i_2) {
                                if (![element_0.e[i_2] isKindOfClass:[NSNumber class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (NSNumber *) element_0.e[i_2];
                                listHolder_2->mList[i_2] = element_2.unsignedIntValue;
                            }
                            listHolder_0->mList[i_0].e = ListType_2(listHolder_2->mList, element_0.e.count);
                        } else {
                            listHolder_0->mList[i_0].e = ListType_2();
                        }
                    }
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].f)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.f.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.f.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.f.count; ++i_2) {
                                if (![element_0.f[i_2] isKindOfClass:[NSData class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (NSData *) element_0.f[i_2];
                                listHolder_2->mList[i_2] = AsByteSpan(element_2);
                            }
                            listHolder_0->mList[i_0].f = ListType_2(listHolder_2->mList, element_0.f.count);
                        } else {
                            listHolder_0->mList[i_0].f = ListType_2();
                        }
                    }
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].g)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.g.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.g.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.g.count; ++i_2) {
                                if (![element_0.g[i_2] isKindOfClass:[NSNumber class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (NSNumber *) element_0.g[i_2];
                                listHolder_2->mList[i_2] = element_2.unsignedCharValue;
                            }
                            listHolder_0->mList[i_0].g = ListType_2(listHolder_2->mList, element_0.g.count);
                        } else {
                            listHolder_0->mList[i_0].g = ListType_2();
                        }
                    }
                }
                encodableStruct.arg1 = ListType_0(listHolder_0->mList, self.arg1.count);
            } else {
                encodableStruct.arg1 = ListType_0();
            }
        }
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg2)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg2.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg2.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg2.count; ++i_0) {
                    if (![self.arg2[i_0] isKindOfClass:[MTRUnitTestingClusterSimpleStruct class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRUnitTestingClusterSimpleStruct *) self.arg2[i_0];
                    listHolder_0->mList[i_0].a = element_0.a.unsignedCharValue;
                    listHolder_0->mList[i_0].b = element_0.b.boolValue;
                    listHolder_0->mList[i_0].c = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].c)>>(element_0.c.unsignedCharValue);
                    listHolder_0->mList[i_0].d = AsByteSpan(element_0.d);
                    listHolder_0->mList[i_0].e = AsCharSpan(element_0.e);
                    listHolder_0->mList[i_0].f = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].f)>>(element_0.f.unsignedCharValue);
                    listHolder_0->mList[i_0].g = element_0.g.floatValue;
                    listHolder_0->mList[i_0].h = element_0.h.doubleValue;
                }
                encodableStruct.arg2 = ListType_0(listHolder_0->mList, self.arg2.count);
            } else {
                encodableStruct.arg2 = ListType_0();
            }
        }
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg3)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg3.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg3.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg3.count; ++i_0) {
                    if (![self.arg3[i_0] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (NSNumber *) self.arg3[i_0];
                    listHolder_0->mList[i_0] = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0])>>(element_0.unsignedCharValue);
                }
                encodableStruct.arg3 = ListType_0(listHolder_0->mList, self.arg3.count);
            } else {
                encodableStruct.arg3 = ListType_0();
            }
        }
    }
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg4)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg4.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg4.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg4.count; ++i_0) {
                    if (![self.arg4[i_0] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (NSNumber *) self.arg4[i_0];
                    listHolder_0->mList[i_0] = element_0.boolValue;
                }
                encodableStruct.arg4 = ListType_0(listHolder_0->mList, self.arg4.count);
            } else {
                encodableStruct.arg4 = ListType_0();
            }
        }
    }
    {
        encodableStruct.arg5 = static_cast<std::remove_reference_t<decltype(encodableStruct.arg5)>>(self.arg5.unsignedCharValue);
    }
    {
        encodableStruct.arg6 = self.arg6.boolValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestStructArrayArgumentRequestParams
@dynamic arg1;
@dynamic arg2;
@dynamic arg3;
@dynamic arg4;
@dynamic arg5;
@dynamic arg6;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestNullableOptionalResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _wasPresent = @(0);

        _wasNull = nil;

        _value = nil;

        _originalValue = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestNullableOptionalResponseParams alloc] init];

    other.wasPresent = self.wasPresent;
    other.wasNull = self.wasNull;
    other.value = self.value;
    other.originalValue = self.originalValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: wasPresent:%@; wasNull:%@; value:%@; originalValue:%@; >", NSStringFromClass([self class]), _wasPresent, _wasNull, _value, _originalValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestNullableOptionalResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestNullableOptionalResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestNullableOptionalResponse::DecodableType &)decodableStruct
{
    {
        self.wasPresent = [NSNumber numberWithBool:decodableStruct.wasPresent];
    }
    {
        if (decodableStruct.wasNull.HasValue()) {
            self.wasNull = [NSNumber numberWithBool:decodableStruct.wasNull.Value()];
        } else {
            self.wasNull = nil;
        }
    }
    {
        if (decodableStruct.value.HasValue()) {
            self.value = [NSNumber numberWithUnsignedChar:decodableStruct.value.Value()];
        } else {
            self.value = nil;
        }
    }
    {
        if (decodableStruct.originalValue.HasValue()) {
            if (decodableStruct.originalValue.Value().IsNull()) {
                self.originalValue = nil;
            } else {
                self.originalValue = [NSNumber numberWithUnsignedChar:decodableStruct.originalValue.Value().Value()];
            }
        } else {
            self.originalValue = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestNullableOptionalResponseParams
@dynamic wasPresent;
@dynamic wasNull;
@dynamic value;
@dynamic originalValue;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestStructArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [MTRUnitTestingClusterSimpleStruct new];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestStructArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestStructArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestStructArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1.a = self.arg1.a.unsignedCharValue;
        encodableStruct.arg1.b = self.arg1.b.boolValue;
        encodableStruct.arg1.c = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.c)>>(self.arg1.c.unsignedCharValue);
        encodableStruct.arg1.d = AsByteSpan(self.arg1.d);
        encodableStruct.arg1.e = AsCharSpan(self.arg1.e);
        encodableStruct.arg1.f = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.f)>>(self.arg1.f.unsignedCharValue);
        encodableStruct.arg1.g = self.arg1.g.floatValue;
        encodableStruct.arg1.h = self.arg1.h.doubleValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestStructArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestComplexNullableOptionalResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _nullableIntWasNull = @(0);

        _nullableIntValue = nil;

        _optionalIntWasPresent = @(0);

        _optionalIntValue = nil;

        _nullableOptionalIntWasPresent = @(0);

        _nullableOptionalIntWasNull = nil;

        _nullableOptionalIntValue = nil;

        _nullableStringWasNull = @(0);

        _nullableStringValue = nil;

        _optionalStringWasPresent = @(0);

        _optionalStringValue = nil;

        _nullableOptionalStringWasPresent = @(0);

        _nullableOptionalStringWasNull = nil;

        _nullableOptionalStringValue = nil;

        _nullableStructWasNull = @(0);

        _nullableStructValue = nil;

        _optionalStructWasPresent = @(0);

        _optionalStructValue = nil;

        _nullableOptionalStructWasPresent = @(0);

        _nullableOptionalStructWasNull = nil;

        _nullableOptionalStructValue = nil;

        _nullableListWasNull = @(0);

        _nullableListValue = nil;

        _optionalListWasPresent = @(0);

        _optionalListValue = nil;

        _nullableOptionalListWasPresent = @(0);

        _nullableOptionalListWasNull = nil;

        _nullableOptionalListValue = nil;
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestComplexNullableOptionalResponseParams alloc] init];

    other.nullableIntWasNull = self.nullableIntWasNull;
    other.nullableIntValue = self.nullableIntValue;
    other.optionalIntWasPresent = self.optionalIntWasPresent;
    other.optionalIntValue = self.optionalIntValue;
    other.nullableOptionalIntWasPresent = self.nullableOptionalIntWasPresent;
    other.nullableOptionalIntWasNull = self.nullableOptionalIntWasNull;
    other.nullableOptionalIntValue = self.nullableOptionalIntValue;
    other.nullableStringWasNull = self.nullableStringWasNull;
    other.nullableStringValue = self.nullableStringValue;
    other.optionalStringWasPresent = self.optionalStringWasPresent;
    other.optionalStringValue = self.optionalStringValue;
    other.nullableOptionalStringWasPresent = self.nullableOptionalStringWasPresent;
    other.nullableOptionalStringWasNull = self.nullableOptionalStringWasNull;
    other.nullableOptionalStringValue = self.nullableOptionalStringValue;
    other.nullableStructWasNull = self.nullableStructWasNull;
    other.nullableStructValue = self.nullableStructValue;
    other.optionalStructWasPresent = self.optionalStructWasPresent;
    other.optionalStructValue = self.optionalStructValue;
    other.nullableOptionalStructWasPresent = self.nullableOptionalStructWasPresent;
    other.nullableOptionalStructWasNull = self.nullableOptionalStructWasNull;
    other.nullableOptionalStructValue = self.nullableOptionalStructValue;
    other.nullableListWasNull = self.nullableListWasNull;
    other.nullableListValue = self.nullableListValue;
    other.optionalListWasPresent = self.optionalListWasPresent;
    other.optionalListValue = self.optionalListValue;
    other.nullableOptionalListWasPresent = self.nullableOptionalListWasPresent;
    other.nullableOptionalListWasNull = self.nullableOptionalListWasNull;
    other.nullableOptionalListValue = self.nullableOptionalListValue;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: nullableIntWasNull:%@; nullableIntValue:%@; optionalIntWasPresent:%@; optionalIntValue:%@; nullableOptionalIntWasPresent:%@; nullableOptionalIntWasNull:%@; nullableOptionalIntValue:%@; nullableStringWasNull:%@; nullableStringValue:%@; optionalStringWasPresent:%@; optionalStringValue:%@; nullableOptionalStringWasPresent:%@; nullableOptionalStringWasNull:%@; nullableOptionalStringValue:%@; nullableStructWasNull:%@; nullableStructValue:%@; optionalStructWasPresent:%@; optionalStructValue:%@; nullableOptionalStructWasPresent:%@; nullableOptionalStructWasNull:%@; nullableOptionalStructValue:%@; nullableListWasNull:%@; nullableListValue:%@; optionalListWasPresent:%@; optionalListValue:%@; nullableOptionalListWasPresent:%@; nullableOptionalListWasNull:%@; nullableOptionalListValue:%@; >", NSStringFromClass([self class]), _nullableIntWasNull, _nullableIntValue, _optionalIntWasPresent, _optionalIntValue, _nullableOptionalIntWasPresent, _nullableOptionalIntWasNull, _nullableOptionalIntValue, _nullableStringWasNull, _nullableStringValue, _optionalStringWasPresent, _optionalStringValue, _nullableOptionalStringWasPresent, _nullableOptionalStringWasNull, _nullableOptionalStringValue, _nullableStructWasNull, _nullableStructValue, _optionalStructWasPresent, _optionalStructValue, _nullableOptionalStructWasPresent, _nullableOptionalStructWasNull, _nullableOptionalStructValue, _nullableListWasNull, _nullableListValue, _optionalListWasPresent, _optionalListValue, _nullableOptionalListWasPresent, _nullableOptionalListWasNull, _nullableOptionalListValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestComplexNullableOptionalResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestComplexNullableOptionalResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestComplexNullableOptionalResponse::DecodableType &)decodableStruct
{
    {
        self.nullableIntWasNull = [NSNumber numberWithBool:decodableStruct.nullableIntWasNull];
    }
    {
        if (decodableStruct.nullableIntValue.HasValue()) {
            self.nullableIntValue = [NSNumber numberWithUnsignedShort:decodableStruct.nullableIntValue.Value()];
        } else {
            self.nullableIntValue = nil;
        }
    }
    {
        self.optionalIntWasPresent = [NSNumber numberWithBool:decodableStruct.optionalIntWasPresent];
    }
    {
        if (decodableStruct.optionalIntValue.HasValue()) {
            self.optionalIntValue = [NSNumber numberWithUnsignedShort:decodableStruct.optionalIntValue.Value()];
        } else {
            self.optionalIntValue = nil;
        }
    }
    {
        self.nullableOptionalIntWasPresent = [NSNumber numberWithBool:decodableStruct.nullableOptionalIntWasPresent];
    }
    {
        if (decodableStruct.nullableOptionalIntWasNull.HasValue()) {
            self.nullableOptionalIntWasNull = [NSNumber numberWithBool:decodableStruct.nullableOptionalIntWasNull.Value()];
        } else {
            self.nullableOptionalIntWasNull = nil;
        }
    }
    {
        if (decodableStruct.nullableOptionalIntValue.HasValue()) {
            self.nullableOptionalIntValue = [NSNumber numberWithUnsignedShort:decodableStruct.nullableOptionalIntValue.Value()];
        } else {
            self.nullableOptionalIntValue = nil;
        }
    }
    {
        self.nullableStringWasNull = [NSNumber numberWithBool:decodableStruct.nullableStringWasNull];
    }
    {
        if (decodableStruct.nullableStringValue.HasValue()) {
            self.nullableStringValue = AsString(decodableStruct.nullableStringValue.Value());
            if (self.nullableStringValue == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.nullableStringValue = nil;
        }
    }
    {
        self.optionalStringWasPresent = [NSNumber numberWithBool:decodableStruct.optionalStringWasPresent];
    }
    {
        if (decodableStruct.optionalStringValue.HasValue()) {
            self.optionalStringValue = AsString(decodableStruct.optionalStringValue.Value());
            if (self.optionalStringValue == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.optionalStringValue = nil;
        }
    }
    {
        self.nullableOptionalStringWasPresent = [NSNumber numberWithBool:decodableStruct.nullableOptionalStringWasPresent];
    }
    {
        if (decodableStruct.nullableOptionalStringWasNull.HasValue()) {
            self.nullableOptionalStringWasNull = [NSNumber numberWithBool:decodableStruct.nullableOptionalStringWasNull.Value()];
        } else {
            self.nullableOptionalStringWasNull = nil;
        }
    }
    {
        if (decodableStruct.nullableOptionalStringValue.HasValue()) {
            self.nullableOptionalStringValue = AsString(decodableStruct.nullableOptionalStringValue.Value());
            if (self.nullableOptionalStringValue == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
        } else {
            self.nullableOptionalStringValue = nil;
        }
    }
    {
        self.nullableStructWasNull = [NSNumber numberWithBool:decodableStruct.nullableStructWasNull];
    }
    {
        if (decodableStruct.nullableStructValue.HasValue()) {
            self.nullableStructValue = [MTRUnitTestingClusterSimpleStruct new];
            self.nullableStructValue.a = [NSNumber numberWithUnsignedChar:decodableStruct.nullableStructValue.Value().a];
            self.nullableStructValue.b = [NSNumber numberWithBool:decodableStruct.nullableStructValue.Value().b];
            self.nullableStructValue.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.nullableStructValue.Value().c)];
            self.nullableStructValue.d = AsData(decodableStruct.nullableStructValue.Value().d);
            self.nullableStructValue.e = AsString(decodableStruct.nullableStructValue.Value().e);
            if (self.nullableStructValue.e == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
            self.nullableStructValue.f = [NSNumber numberWithUnsignedChar:decodableStruct.nullableStructValue.Value().f.Raw()];
            self.nullableStructValue.g = [NSNumber numberWithFloat:decodableStruct.nullableStructValue.Value().g];
            self.nullableStructValue.h = [NSNumber numberWithDouble:decodableStruct.nullableStructValue.Value().h];
        } else {
            self.nullableStructValue = nil;
        }
    }
    {
        self.optionalStructWasPresent = [NSNumber numberWithBool:decodableStruct.optionalStructWasPresent];
    }
    {
        if (decodableStruct.optionalStructValue.HasValue()) {
            self.optionalStructValue = [MTRUnitTestingClusterSimpleStruct new];
            self.optionalStructValue.a = [NSNumber numberWithUnsignedChar:decodableStruct.optionalStructValue.Value().a];
            self.optionalStructValue.b = [NSNumber numberWithBool:decodableStruct.optionalStructValue.Value().b];
            self.optionalStructValue.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.optionalStructValue.Value().c)];
            self.optionalStructValue.d = AsData(decodableStruct.optionalStructValue.Value().d);
            self.optionalStructValue.e = AsString(decodableStruct.optionalStructValue.Value().e);
            if (self.optionalStructValue.e == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
            self.optionalStructValue.f = [NSNumber numberWithUnsignedChar:decodableStruct.optionalStructValue.Value().f.Raw()];
            self.optionalStructValue.g = [NSNumber numberWithFloat:decodableStruct.optionalStructValue.Value().g];
            self.optionalStructValue.h = [NSNumber numberWithDouble:decodableStruct.optionalStructValue.Value().h];
        } else {
            self.optionalStructValue = nil;
        }
    }
    {
        self.nullableOptionalStructWasPresent = [NSNumber numberWithBool:decodableStruct.nullableOptionalStructWasPresent];
    }
    {
        if (decodableStruct.nullableOptionalStructWasNull.HasValue()) {
            self.nullableOptionalStructWasNull = [NSNumber numberWithBool:decodableStruct.nullableOptionalStructWasNull.Value()];
        } else {
            self.nullableOptionalStructWasNull = nil;
        }
    }
    {
        if (decodableStruct.nullableOptionalStructValue.HasValue()) {
            self.nullableOptionalStructValue = [MTRUnitTestingClusterSimpleStruct new];
            self.nullableOptionalStructValue.a = [NSNumber numberWithUnsignedChar:decodableStruct.nullableOptionalStructValue.Value().a];
            self.nullableOptionalStructValue.b = [NSNumber numberWithBool:decodableStruct.nullableOptionalStructValue.Value().b];
            self.nullableOptionalStructValue.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.nullableOptionalStructValue.Value().c)];
            self.nullableOptionalStructValue.d = AsData(decodableStruct.nullableOptionalStructValue.Value().d);
            self.nullableOptionalStructValue.e = AsString(decodableStruct.nullableOptionalStructValue.Value().e);
            if (self.nullableOptionalStructValue.e == nil) {
                CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
                return err;
            }
            self.nullableOptionalStructValue.f = [NSNumber numberWithUnsignedChar:decodableStruct.nullableOptionalStructValue.Value().f.Raw()];
            self.nullableOptionalStructValue.g = [NSNumber numberWithFloat:decodableStruct.nullableOptionalStructValue.Value().g];
            self.nullableOptionalStructValue.h = [NSNumber numberWithDouble:decodableStruct.nullableOptionalStructValue.Value().h];
        } else {
            self.nullableOptionalStructValue = nil;
        }
    }
    {
        self.nullableListWasNull = [NSNumber numberWithBool:decodableStruct.nullableListWasNull];
    }
    {
        if (decodableStruct.nullableListValue.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.nullableListValue.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    NSNumber * newElement_1;
                    newElement_1 = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_1)];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.nullableListValue = array_1;
            }
        } else {
            self.nullableListValue = nil;
        }
    }
    {
        self.optionalListWasPresent = [NSNumber numberWithBool:decodableStruct.optionalListWasPresent];
    }
    {
        if (decodableStruct.optionalListValue.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.optionalListValue.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    NSNumber * newElement_1;
                    newElement_1 = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_1)];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.optionalListValue = array_1;
            }
        } else {
            self.optionalListValue = nil;
        }
    }
    {
        self.nullableOptionalListWasPresent = [NSNumber numberWithBool:decodableStruct.nullableOptionalListWasPresent];
    }
    {
        if (decodableStruct.nullableOptionalListWasNull.HasValue()) {
            self.nullableOptionalListWasNull = [NSNumber numberWithBool:decodableStruct.nullableOptionalListWasNull.Value()];
        } else {
            self.nullableOptionalListWasNull = nil;
        }
    }
    {
        if (decodableStruct.nullableOptionalListValue.HasValue()) {
            { // Scope for our temporary variables
                auto * array_1 = [NSMutableArray new];
                auto iter_1 = decodableStruct.nullableOptionalListValue.Value().begin();
                while (iter_1.Next()) {
                    auto & entry_1 = iter_1.GetValue();
                    NSNumber * newElement_1;
                    newElement_1 = [NSNumber numberWithUnsignedChar:chip::to_underlying(entry_1)];
                    [array_1 addObject:newElement_1];
                }
                CHIP_ERROR err = iter_1.GetStatus();
                if (err != CHIP_NO_ERROR) {
                    return err;
                }
                self.nullableOptionalListValue = array_1;
            }
        } else {
            self.nullableOptionalListValue = nil;
        }
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestComplexNullableOptionalResponseParams
@dynamic nullableIntWasNull;
@dynamic nullableIntValue;
@dynamic optionalIntWasPresent;
@dynamic optionalIntValue;
@dynamic nullableOptionalIntWasPresent;
@dynamic nullableOptionalIntWasNull;
@dynamic nullableOptionalIntValue;
@dynamic nullableStringWasNull;
@dynamic nullableStringValue;
@dynamic optionalStringWasPresent;
@dynamic optionalStringValue;
@dynamic nullableOptionalStringWasPresent;
@dynamic nullableOptionalStringWasNull;
@dynamic nullableOptionalStringValue;
@dynamic nullableStructWasNull;
@dynamic nullableStructValue;
@dynamic optionalStructWasPresent;
@dynamic optionalStructValue;
@dynamic nullableOptionalStructWasPresent;
@dynamic nullableOptionalStructWasNull;
@dynamic nullableOptionalStructValue;
@dynamic nullableListWasNull;
@dynamic nullableListValue;
@dynamic optionalListWasPresent;
@dynamic optionalListValue;
@dynamic nullableOptionalListWasPresent;
@dynamic nullableOptionalListWasNull;
@dynamic nullableOptionalListValue;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestNestedStructArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [MTRUnitTestingClusterNestedStruct new];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestNestedStructArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestNestedStructArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestNestedStructArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1.a = self.arg1.a.unsignedCharValue;
        encodableStruct.arg1.b = self.arg1.b.boolValue;
        encodableStruct.arg1.c.a = self.arg1.c.a.unsignedCharValue;
        encodableStruct.arg1.c.b = self.arg1.c.b.boolValue;
        encodableStruct.arg1.c.c = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.c.c)>>(self.arg1.c.c.unsignedCharValue);
        encodableStruct.arg1.c.d = AsByteSpan(self.arg1.c.d);
        encodableStruct.arg1.c.e = AsCharSpan(self.arg1.c.e);
        encodableStruct.arg1.c.f = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.c.f)>>(self.arg1.c.f.unsignedCharValue);
        encodableStruct.arg1.c.g = self.arg1.c.g.floatValue;
        encodableStruct.arg1.c.h = self.arg1.c.h.doubleValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestNestedStructArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterBooleanResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _value = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterBooleanResponseParams alloc] init];

    other.value = self.value;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: value:%@; >", NSStringFromClass([self class]), _value];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::BooleanResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterBooleanResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::BooleanResponse::DecodableType &)decodableStruct
{
    {
        self.value = [NSNumber numberWithBool:decodableStruct.value];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterBooleanResponseParams
@dynamic value;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestListStructArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestListStructArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestListStructArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestListStructArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg1)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg1.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg1.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg1.count; ++i_0) {
                    if (![self.arg1[i_0] isKindOfClass:[MTRUnitTestingClusterSimpleStruct class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRUnitTestingClusterSimpleStruct *) self.arg1[i_0];
                    listHolder_0->mList[i_0].a = element_0.a.unsignedCharValue;
                    listHolder_0->mList[i_0].b = element_0.b.boolValue;
                    listHolder_0->mList[i_0].c = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].c)>>(element_0.c.unsignedCharValue);
                    listHolder_0->mList[i_0].d = AsByteSpan(element_0.d);
                    listHolder_0->mList[i_0].e = AsCharSpan(element_0.e);
                    listHolder_0->mList[i_0].f = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].f)>>(element_0.f.unsignedCharValue);
                    listHolder_0->mList[i_0].g = element_0.g.floatValue;
                    listHolder_0->mList[i_0].h = element_0.h.doubleValue;
                }
                encodableStruct.arg1 = ListType_0(listHolder_0->mList, self.arg1.count);
            } else {
                encodableStruct.arg1 = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestListStructArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterSimpleStructResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [MTRUnitTestingClusterSimpleStruct new];
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterSimpleStructResponseParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::SimpleStructResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterSimpleStructResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::SimpleStructResponse::DecodableType &)decodableStruct
{
    {
        self.arg1 = [MTRUnitTestingClusterSimpleStruct new];
        self.arg1.a = [NSNumber numberWithUnsignedChar:decodableStruct.arg1.a];
        self.arg1.b = [NSNumber numberWithBool:decodableStruct.arg1.b];
        self.arg1.c = [NSNumber numberWithUnsignedChar:chip::to_underlying(decodableStruct.arg1.c)];
        self.arg1.d = AsData(decodableStruct.arg1.d);
        self.arg1.e = AsString(decodableStruct.arg1.e);
        if (self.arg1.e == nil) {
            CHIP_ERROR err = CHIP_ERROR_INVALID_ARGUMENT;
            return err;
        }
        self.arg1.f = [NSNumber numberWithUnsignedChar:decodableStruct.arg1.f.Raw()];
        self.arg1.g = [NSNumber numberWithFloat:decodableStruct.arg1.g];
        self.arg1.h = [NSNumber numberWithDouble:decodableStruct.arg1.h];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterSimpleStructResponseParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestListInt8UArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestListInt8UArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestListInt8UArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestListInt8UArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg1)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg1.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg1.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg1.count; ++i_0) {
                    if (![self.arg1[i_0] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (NSNumber *) self.arg1[i_0];
                    listHolder_0->mList[i_0] = element_0.unsignedCharValue;
                }
                encodableStruct.arg1 = ListType_0(listHolder_0->mList, self.arg1.count);
            } else {
                encodableStruct.arg1 = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestListInt8UArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestEmitTestEventResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _value = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestEmitTestEventResponseParams alloc] init];

    other.value = self.value;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: value:%@; >", NSStringFromClass([self class]), _value];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestEmitTestEventResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestEmitTestEventResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestEmitTestEventResponse::DecodableType &)decodableStruct
{
    {
        self.value = [NSNumber numberWithUnsignedLongLong:decodableStruct.value];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestEmitTestEventResponseParams
@dynamic value;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestNestedStructListArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [MTRUnitTestingClusterNestedStructList new];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestNestedStructListArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestNestedStructListArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestNestedStructListArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1.a = self.arg1.a.unsignedCharValue;
        encodableStruct.arg1.b = self.arg1.b.boolValue;
        encodableStruct.arg1.c.a = self.arg1.c.a.unsignedCharValue;
        encodableStruct.arg1.c.b = self.arg1.c.b.boolValue;
        encodableStruct.arg1.c.c = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.c.c)>>(self.arg1.c.c.unsignedCharValue);
        encodableStruct.arg1.c.d = AsByteSpan(self.arg1.c.d);
        encodableStruct.arg1.c.e = AsCharSpan(self.arg1.c.e);
        encodableStruct.arg1.c.f = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.c.f)>>(self.arg1.c.f.unsignedCharValue);
        encodableStruct.arg1.c.g = self.arg1.c.g.floatValue;
        encodableStruct.arg1.c.h = self.arg1.c.h.doubleValue;
        {
            using ListType_1 = std::remove_reference_t<decltype(encodableStruct.arg1.d)>;
            using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
            if (self.arg1.d.count != 0) {
                auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.arg1.d.count);
                if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_1);
                for (size_t i_1 = 0; i_1 < self.arg1.d.count; ++i_1) {
                    if (![self.arg1.d[i_1] isKindOfClass:[MTRUnitTestingClusterSimpleStruct class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_1 = (MTRUnitTestingClusterSimpleStruct *) self.arg1.d[i_1];
                    listHolder_1->mList[i_1].a = element_1.a.unsignedCharValue;
                    listHolder_1->mList[i_1].b = element_1.b.boolValue;
                    listHolder_1->mList[i_1].c = static_cast<std::remove_reference_t<decltype(listHolder_1->mList[i_1].c)>>(element_1.c.unsignedCharValue);
                    listHolder_1->mList[i_1].d = AsByteSpan(element_1.d);
                    listHolder_1->mList[i_1].e = AsCharSpan(element_1.e);
                    listHolder_1->mList[i_1].f = static_cast<std::remove_reference_t<decltype(listHolder_1->mList[i_1].f)>>(element_1.f.unsignedCharValue);
                    listHolder_1->mList[i_1].g = element_1.g.floatValue;
                    listHolder_1->mList[i_1].h = element_1.h.doubleValue;
                }
                encodableStruct.arg1.d = ListType_1(listHolder_1->mList, self.arg1.d.count);
            } else {
                encodableStruct.arg1.d = ListType_1();
            }
        }
        {
            using ListType_1 = std::remove_reference_t<decltype(encodableStruct.arg1.e)>;
            using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
            if (self.arg1.e.count != 0) {
                auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.arg1.e.count);
                if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_1);
                for (size_t i_1 = 0; i_1 < self.arg1.e.count; ++i_1) {
                    if (![self.arg1.e[i_1] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_1 = (NSNumber *) self.arg1.e[i_1];
                    listHolder_1->mList[i_1] = element_1.unsignedIntValue;
                }
                encodableStruct.arg1.e = ListType_1(listHolder_1->mList, self.arg1.e.count);
            } else {
                encodableStruct.arg1.e = ListType_1();
            }
        }
        {
            using ListType_1 = std::remove_reference_t<decltype(encodableStruct.arg1.f)>;
            using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
            if (self.arg1.f.count != 0) {
                auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.arg1.f.count);
                if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_1);
                for (size_t i_1 = 0; i_1 < self.arg1.f.count; ++i_1) {
                    if (![self.arg1.f[i_1] isKindOfClass:[NSData class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_1 = (NSData *) self.arg1.f[i_1];
                    listHolder_1->mList[i_1] = AsByteSpan(element_1);
                }
                encodableStruct.arg1.f = ListType_1(listHolder_1->mList, self.arg1.f.count);
            } else {
                encodableStruct.arg1.f = ListType_1();
            }
        }
        {
            using ListType_1 = std::remove_reference_t<decltype(encodableStruct.arg1.g)>;
            using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
            if (self.arg1.g.count != 0) {
                auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.arg1.g.count);
                if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_1);
                for (size_t i_1 = 0; i_1 < self.arg1.g.count; ++i_1) {
                    if (![self.arg1.g[i_1] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_1 = (NSNumber *) self.arg1.g[i_1];
                    listHolder_1->mList[i_1] = element_1.unsignedCharValue;
                }
                encodableStruct.arg1.g = ListType_1(listHolder_1->mList, self.arg1.g.count);
            } else {
                encodableStruct.arg1.g = ListType_1();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestNestedStructListArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestEmitTestFabricScopedEventResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _value = @(0);
        _timedInvokeTimeoutMs = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestEmitTestFabricScopedEventResponseParams alloc] init];

    other.value = self.value;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: value:%@; >", NSStringFromClass([self class]), _value];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::UnitTesting::Commands::TestEmitTestFabricScopedEventResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRUnitTestingClusterTestEmitTestFabricScopedEventResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::UnitTesting::Commands::TestEmitTestFabricScopedEventResponse::DecodableType &)decodableStruct
{
    {
        self.value = [NSNumber numberWithUnsignedLongLong:decodableStruct.value];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRTestClusterClusterTestEmitTestFabricScopedEventResponseParams
@dynamic value;

@dynamic timedInvokeTimeoutMs;
@end
@implementation MTRUnitTestingClusterTestListNestedStructListArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestListNestedStructListArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestListNestedStructListArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestListNestedStructListArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg1)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg1.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg1.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg1.count; ++i_0) {
                    if (![self.arg1[i_0] isKindOfClass:[MTRUnitTestingClusterNestedStructList class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (MTRUnitTestingClusterNestedStructList *) self.arg1[i_0];
                    listHolder_0->mList[i_0].a = element_0.a.unsignedCharValue;
                    listHolder_0->mList[i_0].b = element_0.b.boolValue;
                    listHolder_0->mList[i_0].c.a = element_0.c.a.unsignedCharValue;
                    listHolder_0->mList[i_0].c.b = element_0.c.b.boolValue;
                    listHolder_0->mList[i_0].c.c = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].c.c)>>(element_0.c.c.unsignedCharValue);
                    listHolder_0->mList[i_0].c.d = AsByteSpan(element_0.c.d);
                    listHolder_0->mList[i_0].c.e = AsCharSpan(element_0.c.e);
                    listHolder_0->mList[i_0].c.f = static_cast<std::remove_reference_t<decltype(listHolder_0->mList[i_0].c.f)>>(element_0.c.f.unsignedCharValue);
                    listHolder_0->mList[i_0].c.g = element_0.c.g.floatValue;
                    listHolder_0->mList[i_0].c.h = element_0.c.h.doubleValue;
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].d)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.d.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.d.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.d.count; ++i_2) {
                                if (![element_0.d[i_2] isKindOfClass:[MTRUnitTestingClusterSimpleStruct class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (MTRUnitTestingClusterSimpleStruct *) element_0.d[i_2];
                                listHolder_2->mList[i_2].a = element_2.a.unsignedCharValue;
                                listHolder_2->mList[i_2].b = element_2.b.boolValue;
                                listHolder_2->mList[i_2].c = static_cast<std::remove_reference_t<decltype(listHolder_2->mList[i_2].c)>>(element_2.c.unsignedCharValue);
                                listHolder_2->mList[i_2].d = AsByteSpan(element_2.d);
                                listHolder_2->mList[i_2].e = AsCharSpan(element_2.e);
                                listHolder_2->mList[i_2].f = static_cast<std::remove_reference_t<decltype(listHolder_2->mList[i_2].f)>>(element_2.f.unsignedCharValue);
                                listHolder_2->mList[i_2].g = element_2.g.floatValue;
                                listHolder_2->mList[i_2].h = element_2.h.doubleValue;
                            }
                            listHolder_0->mList[i_0].d = ListType_2(listHolder_2->mList, element_0.d.count);
                        } else {
                            listHolder_0->mList[i_0].d = ListType_2();
                        }
                    }
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].e)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.e.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.e.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.e.count; ++i_2) {
                                if (![element_0.e[i_2] isKindOfClass:[NSNumber class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (NSNumber *) element_0.e[i_2];
                                listHolder_2->mList[i_2] = element_2.unsignedIntValue;
                            }
                            listHolder_0->mList[i_0].e = ListType_2(listHolder_2->mList, element_0.e.count);
                        } else {
                            listHolder_0->mList[i_0].e = ListType_2();
                        }
                    }
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].f)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.f.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.f.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.f.count; ++i_2) {
                                if (![element_0.f[i_2] isKindOfClass:[NSData class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (NSData *) element_0.f[i_2];
                                listHolder_2->mList[i_2] = AsByteSpan(element_2);
                            }
                            listHolder_0->mList[i_0].f = ListType_2(listHolder_2->mList, element_0.f.count);
                        } else {
                            listHolder_0->mList[i_0].f = ListType_2();
                        }
                    }
                    {
                        using ListType_2 = std::remove_reference_t<decltype(listHolder_0->mList[i_0].g)>;
                        using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                        if (element_0.g.count != 0) {
                            auto * listHolder_2 = new ListHolder<ListMemberType_2>(element_0.g.count);
                            if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            listFreer.add(listHolder_2);
                            for (size_t i_2 = 0; i_2 < element_0.g.count; ++i_2) {
                                if (![element_0.g[i_2] isKindOfClass:[NSNumber class]]) {
                                    // Wrong kind of value.
                                    return CHIP_ERROR_INVALID_ARGUMENT;
                                }
                                auto element_2 = (NSNumber *) element_0.g[i_2];
                                listHolder_2->mList[i_2] = element_2.unsignedCharValue;
                            }
                            listHolder_0->mList[i_0].g = ListType_2(listHolder_2->mList, element_0.g.count);
                        } else {
                            listHolder_0->mList[i_0].g = ListType_2();
                        }
                    }
                }
                encodableStruct.arg1 = ListType_0(listHolder_0->mList, self.arg1.count);
            } else {
                encodableStruct.arg1 = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestListNestedStructListArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestListInt8UReverseRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [NSArray array];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestListInt8UReverseRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestListInt8UReverseRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestListInt8UReverseRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        {
            using ListType_0 = std::remove_reference_t<decltype(encodableStruct.arg1)>;
            using ListMemberType_0 = ListMemberTypeGetter<ListType_0>::Type;
            if (self.arg1.count != 0) {
                auto * listHolder_0 = new ListHolder<ListMemberType_0>(self.arg1.count);
                if (listHolder_0 == nullptr || listHolder_0->mList == nullptr) {
                    return CHIP_ERROR_INVALID_ARGUMENT;
                }
                listFreer.add(listHolder_0);
                for (size_t i_0 = 0; i_0 < self.arg1.count; ++i_0) {
                    if (![self.arg1[i_0] isKindOfClass:[NSNumber class]]) {
                        // Wrong kind of value.
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    auto element_0 = (NSNumber *) self.arg1[i_0];
                    listHolder_0->mList[i_0] = element_0.unsignedCharValue;
                }
                encodableStruct.arg1 = ListType_0(listHolder_0->mList, self.arg1.count);
            } else {
                encodableStruct.arg1 = ListType_0();
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestListInt8UReverseRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestEnumsRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);

        _arg2 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestEnumsRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; >", NSStringFromClass([self class]), _arg1, _arg2];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestEnumsRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestEnumsRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1 = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1)>>(self.arg1.unsignedShortValue);
    }
    {
        encodableStruct.arg2 = static_cast<std::remove_reference_t<decltype(encodableStruct.arg2)>>(self.arg2.unsignedCharValue);
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestEnumsRequestParams
@dynamic arg1;
@dynamic arg2;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestNullableOptionalRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestNullableOptionalRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestNullableOptionalRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestNullableOptionalRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.arg1 != nil) {
            auto & definedValue_0 = encodableStruct.arg1.Emplace();
            if (self.arg1 == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                nonNullValue_1 = self.arg1.unsignedCharValue;
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestNullableOptionalRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestComplexNullableOptionalRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _nullableInt = nil;

        _optionalInt = nil;

        _nullableOptionalInt = nil;

        _nullableString = nil;

        _optionalString = nil;

        _nullableOptionalString = nil;

        _nullableStruct = nil;

        _optionalStruct = nil;

        _nullableOptionalStruct = nil;

        _nullableList = nil;

        _optionalList = nil;

        _nullableOptionalList = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestComplexNullableOptionalRequestParams alloc] init];

    other.nullableInt = self.nullableInt;
    other.optionalInt = self.optionalInt;
    other.nullableOptionalInt = self.nullableOptionalInt;
    other.nullableString = self.nullableString;
    other.optionalString = self.optionalString;
    other.nullableOptionalString = self.nullableOptionalString;
    other.nullableStruct = self.nullableStruct;
    other.optionalStruct = self.optionalStruct;
    other.nullableOptionalStruct = self.nullableOptionalStruct;
    other.nullableList = self.nullableList;
    other.optionalList = self.optionalList;
    other.nullableOptionalList = self.nullableOptionalList;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: nullableInt:%@; optionalInt:%@; nullableOptionalInt:%@; nullableString:%@; optionalString:%@; nullableOptionalString:%@; nullableStruct:%@; optionalStruct:%@; nullableOptionalStruct:%@; nullableList:%@; optionalList:%@; nullableOptionalList:%@; >", NSStringFromClass([self class]), _nullableInt, _optionalInt, _nullableOptionalInt, _nullableString, _optionalString, _nullableOptionalString, _nullableStruct, _optionalStruct, _nullableOptionalStruct, _nullableList, _optionalList, _nullableOptionalList];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestComplexNullableOptionalRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestComplexNullableOptionalRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.nullableInt == nil) {
            encodableStruct.nullableInt.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.nullableInt.SetNonNull();
            nonNullValue_0 = self.nullableInt.unsignedShortValue;
        }
    }
    {
        if (self.optionalInt != nil) {
            auto & definedValue_0 = encodableStruct.optionalInt.Emplace();
            definedValue_0 = self.optionalInt.unsignedShortValue;
        }
    }
    {
        if (self.nullableOptionalInt != nil) {
            auto & definedValue_0 = encodableStruct.nullableOptionalInt.Emplace();
            if (self.nullableOptionalInt == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                nonNullValue_1 = self.nullableOptionalInt.unsignedShortValue;
            }
        }
    }
    {
        if (self.nullableString == nil) {
            encodableStruct.nullableString.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.nullableString.SetNonNull();
            nonNullValue_0 = AsCharSpan(self.nullableString);
        }
    }
    {
        if (self.optionalString != nil) {
            auto & definedValue_0 = encodableStruct.optionalString.Emplace();
            definedValue_0 = AsCharSpan(self.optionalString);
        }
    }
    {
        if (self.nullableOptionalString != nil) {
            auto & definedValue_0 = encodableStruct.nullableOptionalString.Emplace();
            if (self.nullableOptionalString == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                nonNullValue_1 = AsCharSpan(self.nullableOptionalString);
            }
        }
    }
    {
        if (self.nullableStruct == nil) {
            encodableStruct.nullableStruct.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.nullableStruct.SetNonNull();
            nonNullValue_0.a = self.nullableStruct.a.unsignedCharValue;
            nonNullValue_0.b = self.nullableStruct.b.boolValue;
            nonNullValue_0.c = static_cast<std::remove_reference_t<decltype(nonNullValue_0.c)>>(self.nullableStruct.c.unsignedCharValue);
            nonNullValue_0.d = AsByteSpan(self.nullableStruct.d);
            nonNullValue_0.e = AsCharSpan(self.nullableStruct.e);
            nonNullValue_0.f = static_cast<std::remove_reference_t<decltype(nonNullValue_0.f)>>(self.nullableStruct.f.unsignedCharValue);
            nonNullValue_0.g = self.nullableStruct.g.floatValue;
            nonNullValue_0.h = self.nullableStruct.h.doubleValue;
        }
    }
    {
        if (self.optionalStruct != nil) {
            auto & definedValue_0 = encodableStruct.optionalStruct.Emplace();
            definedValue_0.a = self.optionalStruct.a.unsignedCharValue;
            definedValue_0.b = self.optionalStruct.b.boolValue;
            definedValue_0.c = static_cast<std::remove_reference_t<decltype(definedValue_0.c)>>(self.optionalStruct.c.unsignedCharValue);
            definedValue_0.d = AsByteSpan(self.optionalStruct.d);
            definedValue_0.e = AsCharSpan(self.optionalStruct.e);
            definedValue_0.f = static_cast<std::remove_reference_t<decltype(definedValue_0.f)>>(self.optionalStruct.f.unsignedCharValue);
            definedValue_0.g = self.optionalStruct.g.floatValue;
            definedValue_0.h = self.optionalStruct.h.doubleValue;
        }
    }
    {
        if (self.nullableOptionalStruct != nil) {
            auto & definedValue_0 = encodableStruct.nullableOptionalStruct.Emplace();
            if (self.nullableOptionalStruct == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                nonNullValue_1.a = self.nullableOptionalStruct.a.unsignedCharValue;
                nonNullValue_1.b = self.nullableOptionalStruct.b.boolValue;
                nonNullValue_1.c = static_cast<std::remove_reference_t<decltype(nonNullValue_1.c)>>(self.nullableOptionalStruct.c.unsignedCharValue);
                nonNullValue_1.d = AsByteSpan(self.nullableOptionalStruct.d);
                nonNullValue_1.e = AsCharSpan(self.nullableOptionalStruct.e);
                nonNullValue_1.f = static_cast<std::remove_reference_t<decltype(nonNullValue_1.f)>>(self.nullableOptionalStruct.f.unsignedCharValue);
                nonNullValue_1.g = self.nullableOptionalStruct.g.floatValue;
                nonNullValue_1.h = self.nullableOptionalStruct.h.doubleValue;
            }
        }
    }
    {
        if (self.nullableList == nil) {
            encodableStruct.nullableList.SetNull();
        } else {
            auto & nonNullValue_0 = encodableStruct.nullableList.SetNonNull();
            {
                using ListType_1 = std::remove_reference_t<decltype(nonNullValue_0)>;
                using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
                if (self.nullableList.count != 0) {
                    auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.nullableList.count);
                    if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    listFreer.add(listHolder_1);
                    for (size_t i_1 = 0; i_1 < self.nullableList.count; ++i_1) {
                        if (![self.nullableList[i_1] isKindOfClass:[NSNumber class]]) {
                            // Wrong kind of value.
                            return CHIP_ERROR_INVALID_ARGUMENT;
                        }
                        auto element_1 = (NSNumber *) self.nullableList[i_1];
                        listHolder_1->mList[i_1] = static_cast<std::remove_reference_t<decltype(listHolder_1->mList[i_1])>>(element_1.unsignedCharValue);
                    }
                    nonNullValue_0 = ListType_1(listHolder_1->mList, self.nullableList.count);
                } else {
                    nonNullValue_0 = ListType_1();
                }
            }
        }
    }
    {
        if (self.optionalList != nil) {
            auto & definedValue_0 = encodableStruct.optionalList.Emplace();
            {
                using ListType_1 = std::remove_reference_t<decltype(definedValue_0)>;
                using ListMemberType_1 = ListMemberTypeGetter<ListType_1>::Type;
                if (self.optionalList.count != 0) {
                    auto * listHolder_1 = new ListHolder<ListMemberType_1>(self.optionalList.count);
                    if (listHolder_1 == nullptr || listHolder_1->mList == nullptr) {
                        return CHIP_ERROR_INVALID_ARGUMENT;
                    }
                    listFreer.add(listHolder_1);
                    for (size_t i_1 = 0; i_1 < self.optionalList.count; ++i_1) {
                        if (![self.optionalList[i_1] isKindOfClass:[NSNumber class]]) {
                            // Wrong kind of value.
                            return CHIP_ERROR_INVALID_ARGUMENT;
                        }
                        auto element_1 = (NSNumber *) self.optionalList[i_1];
                        listHolder_1->mList[i_1] = static_cast<std::remove_reference_t<decltype(listHolder_1->mList[i_1])>>(element_1.unsignedCharValue);
                    }
                    definedValue_0 = ListType_1(listHolder_1->mList, self.optionalList.count);
                } else {
                    definedValue_0 = ListType_1();
                }
            }
        }
    }
    {
        if (self.nullableOptionalList != nil) {
            auto & definedValue_0 = encodableStruct.nullableOptionalList.Emplace();
            if (self.nullableOptionalList == nil) {
                definedValue_0.SetNull();
            } else {
                auto & nonNullValue_1 = definedValue_0.SetNonNull();
                {
                    using ListType_2 = std::remove_reference_t<decltype(nonNullValue_1)>;
                    using ListMemberType_2 = ListMemberTypeGetter<ListType_2>::Type;
                    if (self.nullableOptionalList.count != 0) {
                        auto * listHolder_2 = new ListHolder<ListMemberType_2>(self.nullableOptionalList.count);
                        if (listHolder_2 == nullptr || listHolder_2->mList == nullptr) {
                            return CHIP_ERROR_INVALID_ARGUMENT;
                        }
                        listFreer.add(listHolder_2);
                        for (size_t i_2 = 0; i_2 < self.nullableOptionalList.count; ++i_2) {
                            if (![self.nullableOptionalList[i_2] isKindOfClass:[NSNumber class]]) {
                                // Wrong kind of value.
                                return CHIP_ERROR_INVALID_ARGUMENT;
                            }
                            auto element_2 = (NSNumber *) self.nullableOptionalList[i_2];
                            listHolder_2->mList[i_2] = static_cast<std::remove_reference_t<decltype(listHolder_2->mList[i_2])>>(element_2.unsignedCharValue);
                        }
                        nonNullValue_1 = ListType_2(listHolder_2->mList, self.nullableOptionalList.count);
                    } else {
                        nonNullValue_1 = ListType_2();
                    }
                }
            }
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestComplexNullableOptionalRequestParams
@dynamic nullableInt;
@dynamic optionalInt;
@dynamic nullableOptionalInt;
@dynamic nullableString;
@dynamic optionalString;
@dynamic nullableOptionalString;
@dynamic nullableStruct;
@dynamic optionalStruct;
@dynamic nullableOptionalStruct;
@dynamic nullableList;
@dynamic optionalList;
@dynamic nullableOptionalList;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterSimpleStructEchoRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = [MTRUnitTestingClusterSimpleStruct new];
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterSimpleStructEchoRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterSimpleStructEchoRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::SimpleStructEchoRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1.a = self.arg1.a.unsignedCharValue;
        encodableStruct.arg1.b = self.arg1.b.boolValue;
        encodableStruct.arg1.c = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.c)>>(self.arg1.c.unsignedCharValue);
        encodableStruct.arg1.d = AsByteSpan(self.arg1.d);
        encodableStruct.arg1.e = AsCharSpan(self.arg1.e);
        encodableStruct.arg1.f = static_cast<std::remove_reference_t<decltype(encodableStruct.arg1.f)>>(self.arg1.f.unsignedCharValue);
        encodableStruct.arg1.g = self.arg1.g.floatValue;
        encodableStruct.arg1.h = self.arg1.h.doubleValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterSimpleStructEchoRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTimedInvokeRequestParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTimedInvokeRequestParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTimedInvokeRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TimedInvokeRequest::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTimedInvokeRequestParams

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestSimpleOptionalArgumentRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = nil;
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestSimpleOptionalArgumentRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestSimpleOptionalArgumentRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestSimpleOptionalArgumentRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        if (self.arg1 != nil) {
            auto & definedValue_0 = encodableStruct.arg1.Emplace();
            definedValue_0 = self.arg1.boolValue;
        }
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestSimpleOptionalArgumentRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestEmitTestEventRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);

        _arg2 = @(0);

        _arg3 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestEmitTestEventRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.arg3 = self.arg3;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; arg3:%@; >", NSStringFromClass([self class]), _arg1, _arg2, _arg3];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestEmitTestEventRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestEmitTestEventRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1 = self.arg1.unsignedCharValue;
    }
    {
        encodableStruct.arg2 = static_cast<std::remove_reference_t<decltype(encodableStruct.arg2)>>(self.arg2.unsignedCharValue);
    }
    {
        encodableStruct.arg3 = self.arg3.boolValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestEmitTestEventRequestParams
@dynamic arg1;
@dynamic arg2;
@dynamic arg3;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRUnitTestingClusterTestEmitTestFabricScopedEventRequestParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRUnitTestingClusterTestEmitTestFabricScopedEventRequestParams alloc] init];

    other.arg1 = self.arg1;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; >", NSStringFromClass([self class]), _arg1];
    return descriptionString;
}

@end

@implementation MTRUnitTestingClusterTestEmitTestFabricScopedEventRequestParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::UnitTesting::Commands::TestEmitTestFabricScopedEventRequest::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1 = self.arg1.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRTestClusterClusterTestEmitTestFabricScopedEventRequestParams
@dynamic arg1;

@dynamic timedInvokeTimeoutMs;
@dynamic serverSideProcessingTimeout;
@end
@implementation MTRSampleMEIClusterPingParams
- (instancetype)init
{
    if (self = [super init]) {
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRSampleMEIClusterPingParams alloc] init];

    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: >", NSStringFromClass([self class])];
    return descriptionString;
}

@end

@implementation MTRSampleMEIClusterPingParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::SampleMei::Commands::Ping::Type encodableStruct;
    ListFreer listFreer;

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

@implementation MTRSampleMEIClusterAddArgumentsResponseParams
- (instancetype)init
{
    if (self = [super init]) {

        _returnValue = @(0);
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRSampleMEIClusterAddArgumentsResponseParams alloc] init];

    other.returnValue = self.returnValue;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: returnValue:%@; >", NSStringFromClass([self class]), _returnValue];
    return descriptionString;
}

- (nullable instancetype)initWithResponseValue:(NSDictionary<NSString *, id> *)responseValue
                                         error:(NSError * __autoreleasing *)error
{
    if (!(self = [super init])) {
        return nil;
    }

    using DecodableType = chip::app::Clusters::SampleMei::Commands::AddArgumentsResponse::DecodableType;
    chip::System::PacketBufferHandle buffer = [MTRBaseDevice _responseDataForCommand:responseValue
                                                                           clusterID:DecodableType::GetClusterId()
                                                                           commandID:DecodableType::GetCommandId()
                                                                               error:error];
    if (buffer.IsNull()) {
        return nil;
    }

    chip::TLV::TLVReader reader;
    reader.Init(buffer->Start(), buffer->DataLength());

    CHIP_ERROR err = reader.Next(chip::TLV::AnonymousTag());
    if (err == CHIP_NO_ERROR) {
        DecodableType decodedStruct;
        err = chip::app::DataModel::Decode(reader, decodedStruct);
        if (err == CHIP_NO_ERROR) {
            err = [self _setFieldsFromDecodableStruct:decodedStruct];
            if (err == CHIP_NO_ERROR) {
                return self;
            }
        }
    }

    NSString * errorStr = [NSString stringWithFormat:@"Command payload decoding failed: %s", err.AsString()];
    MTR_LOG_ERROR("%s", errorStr.UTF8String);
    if (error != nil) {
        NSDictionary * userInfo = @{ NSLocalizedFailureReasonErrorKey : NSLocalizedString(errorStr, nil) };
        *error = [NSError errorWithDomain:MTRErrorDomain code:MTRErrorCodeSchemaMismatch userInfo:userInfo];
    }
    return nil;
}

@end

@implementation MTRSampleMEIClusterAddArgumentsResponseParams (InternalMethods)

- (CHIP_ERROR)_setFieldsFromDecodableStruct:(const chip::app::Clusters::SampleMei::Commands::AddArgumentsResponse::DecodableType &)decodableStruct
{
    {
        self.returnValue = [NSNumber numberWithUnsignedChar:decodableStruct.returnValue];
    }
    return CHIP_NO_ERROR;
}

@end

@implementation MTRSampleMEIClusterAddArgumentsParams
- (instancetype)init
{
    if (self = [super init]) {

        _arg1 = @(0);

        _arg2 = @(0);
        _timedInvokeTimeoutMs = nil;
        _serverSideProcessingTimeout = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone;
{
    auto other = [[MTRSampleMEIClusterAddArgumentsParams alloc] init];

    other.arg1 = self.arg1;
    other.arg2 = self.arg2;
    other.timedInvokeTimeoutMs = self.timedInvokeTimeoutMs;
    other.serverSideProcessingTimeout = self.serverSideProcessingTimeout;

    return other;
}

- (NSString *)description
{
    NSString * descriptionString = [NSString stringWithFormat:@"<%@: arg1:%@; arg2:%@; >", NSStringFromClass([self class]), _arg1, _arg2];
    return descriptionString;
}

@end

@implementation MTRSampleMEIClusterAddArgumentsParams (InternalMethods)

- (CHIP_ERROR)_encodeToTLVReader:(chip::System::PacketBufferTLVReader &)reader
{
    chip::app::Clusters::SampleMei::Commands::AddArguments::Type encodableStruct;
    ListFreer listFreer;
    {
        encodableStruct.arg1 = self.arg1.unsignedCharValue;
    }
    {
        encodableStruct.arg2 = self.arg2.unsignedCharValue;
    }

    auto buffer = chip::System::PacketBufferHandle::New(chip::System::PacketBuffer::kMaxSizeWithoutReserve, 0);
    if (buffer.IsNull()) {
        return CHIP_ERROR_NO_MEMORY;
    }

    chip::System::PacketBufferTLVWriter writer;
    // Commands never need chained buffers, since they cannot be chunked.
    writer.Init(std::move(buffer), /* useChainedBuffers = */ false);

    ReturnErrorOnFailure(chip::app::DataModel::Encode(writer, chip::TLV::AnonymousTag(), encodableStruct));

    ReturnErrorOnFailure(writer.Finalize(&buffer));

    reader.Init(std::move(buffer));
    return reader.Next(chip::TLV::kTLVType_Structure, chip::TLV::AnonymousTag());
}

- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    chip::System::PacketBufferTLVReader reader;
    CHIP_ERROR err = [self _encodeToTLVReader:reader];
    if (err != CHIP_NO_ERROR) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:err];
        }
        return nil;
    }

    auto decodedObj = MTRDecodeDataValueDictionaryFromCHIPTLV(&reader);
    if (decodedObj == nil) {
        if (error) {
            *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
        }
    }
    return decodedObj;
}
@end

// MTRBasicClusterMfgSpecificPingParams doesn't need to actually work.
@implementation MTRBasicClusterMfgSpecificPingParams (InternalMethods)
- (NSDictionary<NSString *, id> * _Nullable)_encodeAsDataValue:(NSError * __autoreleasing *)error
{
    if (error) {
        *error = [MTRError errorForCHIPErrorCode:CHIP_ERROR_INCORRECT_STATE];
    }
    return nil;
}
@end

NS_ASSUME_NONNULL_END
