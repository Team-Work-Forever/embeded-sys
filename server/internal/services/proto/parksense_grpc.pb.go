// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.5.1
// - protoc             v3.21.12
// source: parksense.proto

package proto

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.64.0 or later.
const _ = grpc.SupportPackageIsVersion9

const (
	ParkSenseService_StreamIncomingParkLot_FullMethodName = "/parksense.ParkSenseService/StreamIncomingParkLot"
	ParkSenseService_GetAllParkSets_FullMethodName        = "/parksense.ParkSenseService/GetAllParkSets"
	ParkSenseService_CreateReserve_FullMethodName         = "/parksense.ParkSenseService/CreateReserve"
	ParkSenseService_GetUserActiveReserves_FullMethodName = "/parksense.ParkSenseService/GetUserActiveReserves"
	ParkSenseService_GetUserReserveHistory_FullMethodName = "/parksense.ParkSenseService/GetUserReserveHistory"
	ParkSenseService_CancelReserve_FullMethodName         = "/parksense.ParkSenseService/CancelReserve"
)

// ParkSenseServiceClient is the client API for ParkSenseService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type ParkSenseServiceClient interface {
	StreamIncomingParkLot(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (grpc.ServerStreamingClient[ParkSet], error)
	GetAllParkSets(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*ParkSetListResponse, error)
	CreateReserve(ctx context.Context, in *CreateReserveRequest, opts ...grpc.CallOption) (*Reserve, error)
	GetUserActiveReserves(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*ReserveListResponse, error)
	GetUserReserveHistory(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*ReserveHistoryListResponse, error)
	CancelReserve(ctx context.Context, in *CancelReserveRequest, opts ...grpc.CallOption) (*emptypb.Empty, error)
}

type parkSenseServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewParkSenseServiceClient(cc grpc.ClientConnInterface) ParkSenseServiceClient {
	return &parkSenseServiceClient{cc}
}

func (c *parkSenseServiceClient) StreamIncomingParkLot(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (grpc.ServerStreamingClient[ParkSet], error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	stream, err := c.cc.NewStream(ctx, &ParkSenseService_ServiceDesc.Streams[0], ParkSenseService_StreamIncomingParkLot_FullMethodName, cOpts...)
	if err != nil {
		return nil, err
	}
	x := &grpc.GenericClientStream[emptypb.Empty, ParkSet]{ClientStream: stream}
	if err := x.ClientStream.SendMsg(in); err != nil {
		return nil, err
	}
	if err := x.ClientStream.CloseSend(); err != nil {
		return nil, err
	}
	return x, nil
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type ParkSenseService_StreamIncomingParkLotClient = grpc.ServerStreamingClient[ParkSet]

func (c *parkSenseServiceClient) GetAllParkSets(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*ParkSetListResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(ParkSetListResponse)
	err := c.cc.Invoke(ctx, ParkSenseService_GetAllParkSets_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *parkSenseServiceClient) CreateReserve(ctx context.Context, in *CreateReserveRequest, opts ...grpc.CallOption) (*Reserve, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(Reserve)
	err := c.cc.Invoke(ctx, ParkSenseService_CreateReserve_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *parkSenseServiceClient) GetUserActiveReserves(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*ReserveListResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(ReserveListResponse)
	err := c.cc.Invoke(ctx, ParkSenseService_GetUserActiveReserves_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *parkSenseServiceClient) GetUserReserveHistory(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*ReserveHistoryListResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(ReserveHistoryListResponse)
	err := c.cc.Invoke(ctx, ParkSenseService_GetUserReserveHistory_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *parkSenseServiceClient) CancelReserve(ctx context.Context, in *CancelReserveRequest, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, ParkSenseService_CancelReserve_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// ParkSenseServiceServer is the server API for ParkSenseService service.
// All implementations must embed UnimplementedParkSenseServiceServer
// for forward compatibility.
type ParkSenseServiceServer interface {
	StreamIncomingParkLot(*emptypb.Empty, grpc.ServerStreamingServer[ParkSet]) error
	GetAllParkSets(context.Context, *emptypb.Empty) (*ParkSetListResponse, error)
	CreateReserve(context.Context, *CreateReserveRequest) (*Reserve, error)
	GetUserActiveReserves(context.Context, *emptypb.Empty) (*ReserveListResponse, error)
	GetUserReserveHistory(context.Context, *emptypb.Empty) (*ReserveHistoryListResponse, error)
	CancelReserve(context.Context, *CancelReserveRequest) (*emptypb.Empty, error)
	mustEmbedUnimplementedParkSenseServiceServer()
}

// UnimplementedParkSenseServiceServer must be embedded to have
// forward compatible implementations.
//
// NOTE: this should be embedded by value instead of pointer to avoid a nil
// pointer dereference when methods are called.
type UnimplementedParkSenseServiceServer struct{}

func (UnimplementedParkSenseServiceServer) StreamIncomingParkLot(*emptypb.Empty, grpc.ServerStreamingServer[ParkSet]) error {
	return status.Errorf(codes.Unimplemented, "method StreamIncomingParkLot not implemented")
}
func (UnimplementedParkSenseServiceServer) GetAllParkSets(context.Context, *emptypb.Empty) (*ParkSetListResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetAllParkSets not implemented")
}
func (UnimplementedParkSenseServiceServer) CreateReserve(context.Context, *CreateReserveRequest) (*Reserve, error) {
	return nil, status.Errorf(codes.Unimplemented, "method CreateReserve not implemented")
}
func (UnimplementedParkSenseServiceServer) GetUserActiveReserves(context.Context, *emptypb.Empty) (*ReserveListResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetUserActiveReserves not implemented")
}
func (UnimplementedParkSenseServiceServer) GetUserReserveHistory(context.Context, *emptypb.Empty) (*ReserveHistoryListResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetUserReserveHistory not implemented")
}
func (UnimplementedParkSenseServiceServer) CancelReserve(context.Context, *CancelReserveRequest) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method CancelReserve not implemented")
}
func (UnimplementedParkSenseServiceServer) mustEmbedUnimplementedParkSenseServiceServer() {}
func (UnimplementedParkSenseServiceServer) testEmbeddedByValue()                          {}

// UnsafeParkSenseServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ParkSenseServiceServer will
// result in compilation errors.
type UnsafeParkSenseServiceServer interface {
	mustEmbedUnimplementedParkSenseServiceServer()
}

func RegisterParkSenseServiceServer(s grpc.ServiceRegistrar, srv ParkSenseServiceServer) {
	// If the following call pancis, it indicates UnimplementedParkSenseServiceServer was
	// embedded by pointer and is nil.  This will cause panics if an
	// unimplemented method is ever invoked, so we test this at initialization
	// time to prevent it from happening at runtime later due to I/O.
	if t, ok := srv.(interface{ testEmbeddedByValue() }); ok {
		t.testEmbeddedByValue()
	}
	s.RegisterService(&ParkSenseService_ServiceDesc, srv)
}

func _ParkSenseService_StreamIncomingParkLot_Handler(srv interface{}, stream grpc.ServerStream) error {
	m := new(emptypb.Empty)
	if err := stream.RecvMsg(m); err != nil {
		return err
	}
	return srv.(ParkSenseServiceServer).StreamIncomingParkLot(m, &grpc.GenericServerStream[emptypb.Empty, ParkSet]{ServerStream: stream})
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type ParkSenseService_StreamIncomingParkLotServer = grpc.ServerStreamingServer[ParkSet]

func _ParkSenseService_GetAllParkSets_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(emptypb.Empty)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ParkSenseServiceServer).GetAllParkSets(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ParkSenseService_GetAllParkSets_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ParkSenseServiceServer).GetAllParkSets(ctx, req.(*emptypb.Empty))
	}
	return interceptor(ctx, in, info, handler)
}

func _ParkSenseService_CreateReserve_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(CreateReserveRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ParkSenseServiceServer).CreateReserve(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ParkSenseService_CreateReserve_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ParkSenseServiceServer).CreateReserve(ctx, req.(*CreateReserveRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _ParkSenseService_GetUserActiveReserves_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(emptypb.Empty)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ParkSenseServiceServer).GetUserActiveReserves(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ParkSenseService_GetUserActiveReserves_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ParkSenseServiceServer).GetUserActiveReserves(ctx, req.(*emptypb.Empty))
	}
	return interceptor(ctx, in, info, handler)
}

func _ParkSenseService_GetUserReserveHistory_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(emptypb.Empty)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ParkSenseServiceServer).GetUserReserveHistory(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ParkSenseService_GetUserReserveHistory_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ParkSenseServiceServer).GetUserReserveHistory(ctx, req.(*emptypb.Empty))
	}
	return interceptor(ctx, in, info, handler)
}

func _ParkSenseService_CancelReserve_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(CancelReserveRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ParkSenseServiceServer).CancelReserve(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ParkSenseService_CancelReserve_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ParkSenseServiceServer).CancelReserve(ctx, req.(*CancelReserveRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// ParkSenseService_ServiceDesc is the grpc.ServiceDesc for ParkSenseService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var ParkSenseService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "parksense.ParkSenseService",
	HandlerType: (*ParkSenseServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "GetAllParkSets",
			Handler:    _ParkSenseService_GetAllParkSets_Handler,
		},
		{
			MethodName: "CreateReserve",
			Handler:    _ParkSenseService_CreateReserve_Handler,
		},
		{
			MethodName: "GetUserActiveReserves",
			Handler:    _ParkSenseService_GetUserActiveReserves_Handler,
		},
		{
			MethodName: "GetUserReserveHistory",
			Handler:    _ParkSenseService_GetUserReserveHistory_Handler,
		},
		{
			MethodName: "CancelReserve",
			Handler:    _ParkSenseService_CancelReserve_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "StreamIncomingParkLot",
			Handler:       _ParkSenseService_StreamIncomingParkLot_Handler,
			ServerStreams: true,
		},
	},
	Metadata: "parksense.proto",
}
