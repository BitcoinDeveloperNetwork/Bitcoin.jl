@testset "Stack Operators" begin
    @testset "encode/decode num" begin
        tests = [([0x75, 0x39, 0xd7, 0xf9], -2044148085),
        ([0x1b, 0x44, 0x8d, 0x17, 0x61, 0x36, 0x45, 0x51, 0x44, 0x38, 0x15, 0x20, 0xeb, 0x3f, 0xd1, 0xbc], -80840166210881125725200074314630382619),
        ([0xd3, 0x2c, 0xd5, 0xb9, 0x8b, 0xfa, 0x37, 0xd5, 0x24, 0xd0, 0xd2, 0xe8, 0x81, 0x8c, 0xcb, 0x15, 0xe5, 0xfe, 0xdd, 0x95, 0x55, 0xe4, 0x3d, 0x01, 0x82, 0x67, 0xc2, 0x23, 0xc5, 0xd6, 0x0c, 0x90, 0xe9, 0x72, 0xff, 0x9a, 0xd1, 0xcf, 0x16, 0xfa, 0x83], -8494629442587523471751141882831378743107401446683360409874466988135963066279425110931949604908243),
        ([0x7e, 0x5e, 0x14, 0x7b, 0x73, 0x6b, 0x57, 0x64, 0x67, 0x6d, 0x0b, 0x70, 0xa1, 0x6e, 0x71], 588973400481137931526979715425656446),
        ([0x7b], 123)]
        for i in 1:length(tests)
            @test Bitcoin.decode_num(tests[i][1]) == tests[i][2]
            @test Bitcoin.encode_num(tests[i][2]) == tests[i][1]
        end
    end
    @testset "Push value onto stack" begin
        test_stack = [[0x75, 0x39, 0xd7, 0xf9],
        [0x86, 0x8f, 0xf9, 0x73, 0x0a, 0x3c, 0x0c, 0xb9],
        [0xe2, 0xd6],
        [0x7b],
        [0x92, 0x8b, 0xae, 0xed, 0x1e, 0xfb, 0x04, 0x58],
        [0xdb, 0xaf, 0x44],
        [0x84, 0xd7, 0x35, 0xb7],
        [0xaf, 0x80, 0x91]]
        empty_stack = UInt8[]
        @testset "op_0" begin
            stack = test_stack
            want = stack
            push!(want, UInt8[])
            @test Bitcoin.op_0(stack) == true
            @test stack == want
        end
        @testset "op_1negate" begin
            stack = test_stack
            want = stack
            push!(want, [0x81])
            @test Bitcoin.op_1negate(stack) == true
            @test stack == want
        end
        @testset "op_2" begin
            stack = test_stack
            want = stack
            push!(want, [0x02])
            @test Bitcoin.op_2(stack) == true
            @test stack == want
        end
        @testset "op_3" begin
            stack = test_stack
            want = stack
            push!(want, [0x03])
            @test Bitcoin.op_3(stack) == true
            @test stack == want
        end
        @testset "op_4" begin
            stack = test_stack
            want = stack
            push!(want, [0x01])
            @test Bitcoin.op_4(stack) == true
            @test stack == want
        end
        @testset "op_5" begin
            stack = test_stack
            want = stack
            push!(want, [0x05])
            @test Bitcoin.op_5(stack) == true
            @test stack == want
        end
        @testset "op_6" begin
            stack = test_stack
            want = stack
            push!(want, [0x06])
            @test Bitcoin.op_6(stack) == true
            @test stack == want
        end
        @testset "op_7" begin
            stack = test_stack
            want = stack
            push!(want, [0x07])
            @test Bitcoin.op_7(stack) == true
            @test stack == want
        end
        @testset "op_8" begin
            stack = test_stack
            want = stack
            push!(want, [0x08])
            @test Bitcoin.op_8(stack) == true
            @test stack == want
        end
        @testset "op_9" begin
            stack = test_stack
            want = stack
            push!(want, [0x09])
            @test Bitcoin.op_9(stack) == true
            @test stack == want
        end
        @testset "op_10" begin
            stack = test_stack
            want = stack
            push!(want, [0x0a])
            @test Bitcoin.op_10(stack) == true
            @test stack == want
        end
        @testset "op_11" begin
            stack = test_stack
            want = stack
            push!(want, [0x0b])
            @test Bitcoin.op_11(stack) == true
            @test stack == want
        end
        @testset "op_12" begin
            stack = test_stack
            want = stack
            push!(want, [0x0c])
            @test Bitcoin.op_12(stack) == true
            @test stack == want
        end
        @testset "op_13" begin
            stack = test_stack
            want = stack
            push!(want, [0x0d])
            @test Bitcoin.op_13(stack) == true
            @test stack == want
        end
        @testset "op_14" begin
            stack = test_stack
            want = stack
            push!(want, [0x0e])
            @test Bitcoin.op_14(stack) == true
            @test stack == want
        end
        @testset "op_15" begin
            stack = test_stack
            want = stack
            push!(want, [0x0f])
            @test Bitcoin.op_15(stack) == true
            @test stack == want
        end
        @testset "op_16" begin
            stack = test_stack
            want = stack
            push!(want, [0x10])
            @test Bitcoin.op_16(stack) == true
            @test stack == want
        end
    end
    @testset "Conditional control flow" begin
        @testset "op_nop" begin
            @test Bitcoin.op_nop([UInt8[]]) == true
            @test Bitcoin.op_nop([[0x64],
                [0x86, 0x8f, 0xf9, 0x73, 0x0a, 0x3c, 0x0c, 0xb9],
                [0xe2, 0xd6]]) == true
        end
        # TODO review those tests
        @testset "op_if" begin
            want = [[0x64],
                [0x86, 0x8f, 0xf9, 0x73, 0x0a, 0x3c, 0x0c, 0xb9],
                [0xe2, 0xd6]]
            stack = Array{UInt8,1}[]
            items = [0x63,0x0c,0xe2]
            @test Bitcoin.op_if(stack,items) == false
            @test stack == []
            @test items == [0x63,0x0c,0xe2]

            stack = want
            @test Bitcoin.op_if(stack,items) == false
            @test stack == want
            @test items == UInt8[]

            items == [0x67,0x0d,0x69]
            @test Bitcoin.op_if(stack,items) == false
            @test stack == want
            @test items == UInt8[]

            items == [0x63,0x68,0x6b]
            @test Bitcoin.op_if(stack,items) == false
            @test stack == want
            @test items == UInt8[]

            items == [0x0d,0x0f,0x7a]
            @test Bitcoin.op_if(stack,items) == false
            @test stack == want
            @test items == UInt8[]

            push!(stack,UInt8[])
            items = [0x68,0xc4,0x07]
            @test Bitcoin.op_if(stack,items) == true
            @test stack == want
            @test items == [0xc4,0x07]

            items = [0x68,0xc4,0x07]
            @test Bitcoin.op_if(stack,items) == true
            pop!(want)
            @test stack == want
            @test items == [0xc4,0x07]
        end
        # TODO create those tests
        @testset "op_notif" begin
        end
        @testset "op_verify" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_verify(stack) == false
            @test stack ==  Array{UInt8,1}[]
            stack = [[0x64], [0x86, 0x8f, 0xf9], [0xe2, 0xd6]]
            @test Bitcoin.op_verify(stack) == true
            @test stack ==  [[0x64], [0x86, 0x8f, 0xf9]]
            stack = [[0x64], [0x86, 0x8f, 0xf9], [0xe2, 0xd6], UInt8[]]
            @test Bitcoin.op_verify(stack) == false
            @test stack ==  [[0x64], [0x86, 0x8f, 0xf9], [0xe2, 0xd6]]
        end
        @testset "op_return" begin
            @test Bitcoin.op_return([UInt8[]]) == false
            @test Bitcoin.op_return([[0x64],
                [0x86, 0x8f, 0xf9, 0x73, 0x0a, 0x3c, 0x0c, 0xb9],
                [0xe2, 0xd6]]) == false
        end
    end
    @testset "Timelock operations" begin
        empty = Array{UInt8,1}[]
        stack = Array{UInt8,1}[[0x03], [0x04]]
        @testset "op_checklocktimeverify" begin
            @test Bitcoin.op_checklocktimeverify(stack, 1, 0xffffffff) == false
            @test Bitcoin.op_checklocktimeverify(empty, 100, 1) == false
            push!(stack, [0x81])
            @test Bitcoin.op_checklocktimeverify(stack, 100, 1) == false
            pop!(stack)
            @test Bitcoin.op_checklocktimeverify(stack, 500000001, 1) == false
            @test Bitcoin.op_checklocktimeverify(stack, 1, 1) == false
            @test Bitcoin.op_checklocktimeverify(stack, 100, 1) == true
        end
        # TODO
        @testset "op_checksequenceverify" begin
        end
    end
    @testset "Stack operations" begin
        @testset "op_toaltstack" begin
            stack = Array{UInt8,1}[]
            altstack = stack
            @test Bitcoin.op_toaltstack(stack, altstack) == false
            stack = [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06]]
            altstack = [[0xf4], [0xf6, 0xff, 0xf9], [0xf2, 0xf6]]
            @test Bitcoin.op_toaltstack(stack, altstack) == true
            @test stack == [[0x04], [0x06, 0x0f, 0x09]] && altstack == [[0xf4], [0xf6, 0xff, 0xf9], [0xf2, 0xf6], [0x02, 0x06]]
        end
        @testset "op_fromaltstack" begin
            stack = Array{UInt8,1}[]
            altstack = stack
            @test Bitcoin.op_toaltstack(stack, altstack) == false
            stack = [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06]]
            altstack = [[0xf4], [0xf6, 0xff, 0xf9], [0xf2, 0xf6]]
            @test Bitcoin.op_fromaltstack(stack, altstack) == true
            @test stack == [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06],[0xf2, 0xf6]] && altstack == [[0xf4], [0xf6, 0xff, 0xf9]]
        end
        @testset "op_2drop" begin
            stack = [[0x04]]
            @test Bitcoin.op_2drop(stack) == false
            stack = [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06]]
            @test Bitcoin.op_2drop(stack) == true
            @test stack == [[0x04]]
        end
        @testset "op_2dup" begin
            stack = [[0x04]]
            @test Bitcoin.op_2dup(stack) == false
            stack = [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06]]
            @test Bitcoin.op_2dup(stack) == true
            @test stack == [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06], [0x06, 0x0f, 0x09], [0x02, 0x06]]
        end
        @testset "op_3dup" begin
            stack = [[0x04], [0x06, 0x0f, 0x09]]
            @test Bitcoin.op_3dup(stack) == false
            stack = [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06]]
            @test Bitcoin.op_3dup(stack) == true
            @test stack == [[0x04], [0x06, 0x0f, 0x09], [0x02, 0x06], [0x04], [0x06, 0x0f, 0x09], [0x02, 0x06]]
        end
        @testset "op_2over" begin
            stack = [[0x01], [0x02], [0x03]]
            @test Bitcoin.op_2over(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04], [0x05]]
            @test Bitcoin.op_2over(stack) == true
            @test stack == [[0x01], [0x02], [0x03], [0x04], [0x05], [0x02], [0x03]]
        end
        @testset "op_2rot" begin
            stack = [[0x01], [0x02], [0x03], [0x04], [0x05]]
            @test Bitcoin.op_2rot(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04], [0x05], [0x06], [0x07]]
            @test Bitcoin.op_2rot(stack) == true
            @test stack == [[0x01], [0x02], [0x03], [0x04], [0x05], [0x06], [0x07], [0x02], [0x03]]
        end
        @testset "op_2swap" begin
            stack = [[0x01], [0x02], [0x03]]
            @test Bitcoin.op_2swap(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04], [0x05]]
            @test Bitcoin.op_2swap(stack) == true
            @test stack == [[0x01], [0x04], [0x05], [0x02], [0x03]]
        end
        @testset "op_ifdup" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_ifdup(stack) == false
            stack = [[0x01], [0x00]]
            @test Bitcoin.op_ifdup(stack) == true
            @test stack == [[0x01], [0x00]]
            stack = [[0x01], [0x02]]
            @test Bitcoin.op_ifdup(stack) == true
            @test stack == [[0x01], [0x02], [0x02]]
        end
        @testset "op_depth" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_depth(stack) == true
            @test stack == [[]]
            stack = [[0x01], [0x02]]
            @test Bitcoin.op_depth(stack) == true
            @test stack == [[0x01], [0x02], [0x02]]
        end
        @testset "op_dup" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_dup(stack) == false
            stack = [[0x01], [0x02], [0x03]]
            @test Bitcoin.op_dup(stack) == true
            @test stack == [[0x01], [0x02], [0x03], [0x03]]
        end
        @testset "op_nip" begin
            stack = Array{UInt8,1}[[0x01]]
            @test Bitcoin.op_nip(stack) == false
            stack = [[0x01], [0x02], [0x03]]
            @test Bitcoin.op_nip(stack) == true
            @test stack == [[0x01], [0x03]]
        end
        @testset "op_over" begin
            stack = [[0x01]]
            @test Bitcoin.op_over(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_over(stack) == true
            @test stack == [[0x01], [0x02], [0x03], [0x04], [0x03]]
        end
        @testset "op_pick" begin
            stack = Array{UInt8,1}[[0x01]]
            @test Bitcoin.op_pick(stack) == false
            stack = [[0x01], [0x0b], [0x03], [0x05]]
            @test Bitcoin.op_pick(stack) == false
            stack = [[0x01], [0x0b], [0x03], [0x02]]
            @test Bitcoin.op_pick(stack) == true
            @test stack == [[0x01], [0x0b], [0x03], [0x0b]]
        end
        @testset "op_roll" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_roll(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_roll(stack) == false
            @test stack == [[0x01], [0x02], [0x03]]
            stack = [[0x01], [0x0b], [0x03], [0x00]]
            @test Bitcoin.op_roll(stack) == true
            @test stack == [[0x01], [0x0b], [0x03]]
            stack = [[0x01], [0x0b], [0x03], [0x02]]
            @test Bitcoin.op_roll(stack) == true
            @test stack == [[0x01], [0x03], [0x0b]]
        end
        @testset "op_rot" begin
            stack = [[0x01], [0x02]]
            @test Bitcoin.op_rot(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_rot(stack) == true
            @test stack == [[0x01], [0x03], [0x04], [0x02]]
        end
        @testset "op_swap" begin
            stack = [[0x01]]
            @test Bitcoin.op_swap(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_swap(stack) == true
            @test stack == [[0x01], [0x02], [0x04], [0x03]]
        end
        @testset "op_tuck" begin
            stack = [[0x01]]
            @test Bitcoin.op_tuck(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_tuck(stack) == true
            @test stack == [[0x01], [0x02], [0x04], [0x03], [0x04]]
        end
    end
    @testset "String splice operations" begin
        @testset "op_size" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_size(stack) == false
            stack = [[0x01], [0x02], [0x01, 0x08]]
            @test Bitcoin.op_size(stack) == true
            @test stack == [[0x01], [0x02], [0x01, 0x08], [0x02]]
        end
    end
    @testset "Binary arithmetic and conditionals" begin
        @testset "op_equal" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_equal(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_equal(stack) == true
            @test stack == [[0x01], [0x02], []]
            stack = [[0x01], [0x02], [0x03], [0x03]]
            @test Bitcoin.op_equal(stack) == true
            @test stack == [[0x01], [0x02], [0x01]]
        end
        @testset "op_equalverify" begin
            stack = Array{UInt8,1}[]
            @test Bitcoin.op_equalverify(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_equalverify(stack) == false
            stack = [[0x01], [0x02], [0x03], [0x03]]
            @test Bitcoin.op_equalverify(stack) == true
        end
    end
    @testset "Numeric operators" begin
        empty = Array{UInt8,1}[]
        stack = Array{UInt8,1}[[0x03]]
        @testset "op_1add" begin
            @test Bitcoin.op_1add(empty) == false
            @test Bitcoin.op_1add(stack) == true
            @test stack == [[0x04]]
        end
        @testset "op_1sub" begin
            @test Bitcoin.op_1sub(empty) == false
            @test Bitcoin.op_1sub(stack) == true
            @test stack == [[0x03]]
        end
        @testset "op_negate" begin
            @test Bitcoin.op_negate(empty) == false
            @test Bitcoin.op_negate(stack) == true
            @test stack == [[0x83]]
        end
        @testset "op_abs" begin
            @test Bitcoin.op_abs(empty) == false
            @test Bitcoin.op_abs(stack) == true
            @test stack == [[0x03]]
            @test Bitcoin.op_abs(stack) == true
            @test stack == [[0x03]]
        end
        @testset "op_not" begin
            @test Bitcoin.op_not(empty) == false
            @test Bitcoin.op_not(stack) == true
            @test stack == [UInt8[]]
            @test Bitcoin.op_not(stack) == true
            @test stack == [[0x01]]
        end
        @testset "op_0notequal" begin
            @test Bitcoin.op_0notequal(empty) == false
            stack = [[0x1a]]
            @test Bitcoin.op_0notequal(stack) == true
            @test stack == [[0x01]]
            stack = [[0x00]]
            @test Bitcoin.op_0notequal(stack) == true
            @test stack == [UInt8[]]
        end
        @testset "op_add" begin
            @test Bitcoin.op_add(empty) == false
            stack = [[0x09], [0x02], [0x03]]
            @test Bitcoin.op_add(stack) == true
            @test stack == [[0x09], [0x05]]
        end
        @testset "op_sub" begin
            @test Bitcoin.op_sub(empty) == false
            @test Bitcoin.op_sub(stack) == true
            @test stack == [[0x04]]
        end
        @testset "op_booland" begin
            @test Bitcoin.op_booland(empty) == false
            stack = [[0x00], [0x00]]
            @test Bitcoin.op_booland(stack) == true
            @test stack == [UInt8[]]
            stack = [[0x01], [0x00]]
            @test Bitcoin.op_booland(stack) == true
            @test stack == [UInt8[]]
            stack = [[0x00], [0x01]]
            @test Bitcoin.op_booland(stack) == true
            @test stack == [UInt8[]]
            stack = [[0x01], [0x01]]
            @test Bitcoin.op_booland(stack) == true
            @test stack == [UInt8[0x01]]
        end
        @testset "op_boolor" begin
            @test Bitcoin.op_boolor(empty) == false
            stack = [[0x00], [0x00]]
            @test Bitcoin.op_boolor(stack) == true
            @test stack == [UInt8[]]
            stack = [[0x00], [0x01]]
            @test Bitcoin.op_boolor(stack) == true
            @test stack == [UInt8[0x01]]
            stack = [[0x01], [0x00]]
            @test Bitcoin.op_boolor(stack) == true
            @test stack == [UInt8[0x01]]
            stack = [[0x01], [0x01]]
            @test Bitcoin.op_boolor(stack) == true
            @test stack == [UInt8[0x01]]
        end
        @testset "op_numequal" begin
            @test Bitcoin.op_numequal(empty) == false
            stack = [[0x01], [0x02], [0x00], [0x00]]
            @test Bitcoin.op_numequal(stack) == true
            @test stack == [[0x01], [0x02], [0x01]]
            @test Bitcoin.op_numequal(stack) == true
            @test stack == [[0x01], UInt8[]]
        end
        @testset "op_numequalverify" begin
            @test Bitcoin.op_numequalverify(empty) == false
            stack = [[0x01], [0x02], [0x00], [0x00]]
            @test Bitcoin.op_numequalverify(stack) == true
            @test stack == [[0x01], [0x02]]
            @test Bitcoin.op_numequalverify(stack) == false
            @test stack == empty
        end
        @testset "op_numnotequal" begin
            @test Bitcoin.op_numnotequal(empty) == false
            stack = [[0x01], [0x02], [0x03], [0x03]]
            @test Bitcoin.op_numnotequal(stack) == true
            @test stack == [[0x01], [0x02], UInt8[]]
            stack = [[0x01], [0x02], [0x03], [0x04]]
            @test Bitcoin.op_numnotequal(stack) == true
            @test stack == [[0x01], [0x02], [0x01]]
        end
        @testset "op_lessthan" begin
            @test Bitcoin.op_lessthan(empty) == false
            stack = [[0x01], [0x01], [0x03], [0x04]]
            @test Bitcoin.op_lessthan(stack) == true
            @test stack == [[0x01], [0x01], [0x01]]
            @test Bitcoin.op_lessthan(stack) == true
            @test stack == [[0x01], UInt8[]]
        end
        @testset "op_greaterthan" begin
            @test Bitcoin.op_greaterthan(empty) == false
            stack = [[0x04], [0x01], [0x02], [0x01]]
            @test Bitcoin.op_greaterthan(stack) == true
            @test stack == [[0x04], [0x01], [0x01]]
            @test Bitcoin.op_greaterthan(stack) == true
            @test stack == [[0x04], UInt8[]]
        end
        @testset "op_lessthanorequal" begin
            @test Bitcoin.op_lessthanorequal(empty) == false
            stack = [[0x01], [0x02], [0x04], [0x04]]
            @test Bitcoin.op_lessthanorequal(stack) == true
            @test stack == [[0x01], [0x02], [0x01]]
            @test Bitcoin.op_lessthanorequal(stack) == true
            @test stack == [[0x01], UInt8[]]
        end
        @testset "op_greaterthanorequal" begin
            @test Bitcoin.op_greaterthanorequal(empty) == false
            stack = [[0x04], [0x00], [0x02], [0x02]]
            @test Bitcoin.op_greaterthanorequal(stack) == true
            @test stack == [[0x04], [0x00], [0x01]]
            @test Bitcoin.op_greaterthanorequal(stack) == true
            @test stack == [[0x04], UInt8[]]
        end
        @testset "op_min" begin
            @test Bitcoin.op_min(empty) == false
            stack = [[0x01], [0x08], [0x03], [0x04]]
            @test Bitcoin.op_min(stack) == true
            @test stack == [[0x01], [0x08], [0x03]]
            @test Bitcoin.op_min(stack) == true
            @test stack == [[0x01], [0x03]]
        end
        @testset "op_max" begin
            @test Bitcoin.op_max(empty) == false
            stack = [[0x01], [0x08], [0x03], [0x04]]
            @test Bitcoin.op_max(stack) == true
            @test stack == [[0x01], [0x08], [0x04]]
            @test Bitcoin.op_max(stack) == true
            @test stack == [[0x01], [0x08]]
        end
        @testset "op_within" begin
            @test Bitcoin.op_within(empty) == false
            stack = [[0xa1], [0x02], [0x02], [0x04]]
            @test Bitcoin.op_within(stack) == true
            @test stack == [[0xa1], [0x01]]
            stack = [[0xa1], [0x08], [0x02], [0x04]]
            @test Bitcoin.op_within(stack) == true
            @test stack == [[0xa1], UInt8[]]
        end
    end
    @testset "Cryptographic and hashing operations" begin
        empty = Array{UInt8,1}[]
        stack = Array{UInt8,1}[[0x03], [0x04]]
        @testset "op_ripemd160" begin
            @test Bitcoin.op_ripemd160(empty) == false
            @test Bitcoin.op_ripemd160(stack) == true
            @test stack == Array{UInt8,1}[[0x03], [0x44, 0x9b, 0x34, 0xb6, 0xa3, 0x41, 0x19, 0x43, 0xe3, 0x3a, 0x25, 0x87, 0xeb, 0xf2, 0x81, 0xca, 0xff, 0x16, 0x74, 0x98]]
        end
        stack = Array{UInt8,1}[[0x03], [0x04]]
        @testset "op_sha1" begin
            @test Bitcoin.op_sha1(empty) == false
            @test Bitcoin.op_sha1(stack) == true
            @test stack == Array{UInt8,1}[[0x03], [0xa4, 0x2c, 0x6c, 0xf1, 0xde, 0x3a, 0xbf, 0xde, 0xa9, 0xb9, 0x5f, 0x34, 0x68, 0x7c, 0xbb, 0xe9, 0x2b, 0x9a, 0x73, 0x83]]
        end
        stack = Array{UInt8,1}[[0x03], [0x04]]
        @testset "op_sha256" begin
            @test Bitcoin.op_sha256(empty) == false
            @test Bitcoin.op_sha256(stack) == true
            @test stack == Array{UInt8,1}[[0x03], [0xe5, 0x2d, 0x9c, 0x50, 0x8c, 0x50, 0x23, 0x47, 0x34, 0x4d, 0x8c, 0x07, 0xad, 0x91, 0xcb, 0xd6, 0x06, 0x8a, 0xfc, 0x75, 0xff, 0x62, 0x92, 0xf0, 0x62, 0xa0, 0x9c, 0xa3, 0x81, 0xc8, 0x9e, 0x71]]
        end
        stack = Array{UInt8,1}[[0x03], [0x04]]
        @testset "op_hash160" begin
            @test Bitcoin.op_hash160(empty) == false
            @test Bitcoin.op_hash160(stack) == true
            @test stack == Array{UInt8,1}[[0x03], [0x6d, 0x4c, 0x0a, 0xa9, 0x72, 0xc3, 0x14, 0x84, 0x0a, 0xc0, 0x7b, 0xe9, 0x6c, 0x5d, 0xde, 0x9c, 0x71, 0x4c, 0x9c, 0xa4]]
        end
        stack = Array{UInt8,1}[[0x03], [0x04]]
        @testset "op_hash256" begin
            @test Bitcoin.op_hash256(empty) == false
            @test Bitcoin.op_hash256(stack) == true
            @test stack == Array{UInt8,1}[[0x03], [0x21, 0x4e, 0x63, 0xbf, 0x41, 0x49, 0x0e, 0x67, 0xd3, 0x44, 0x76, 0x77, 0x8f, 0x67, 0x07, 0xaa, 0x6c, 0x8d, 0x2c, 0x8d, 0xcc, 0xdf, 0x78, 0xae, 0x11, 0xe4, 0x0e, 0xe9, 0xf9, 0x1e, 0x89, 0xa7]]
        end
        # TODO
        @testset "op_codeseparator" begin
        end
        # TODO
        @testset "op_checksig" begin
            z = parse(BigInt, "7c076ff316692a3d7eb3c3bb0f8b1488cf72e1afcd929e29307032997a838a3d", base=16)
            sec = hex2bytes("04887387e452b8eacc4acfde10d9aaf7f6d9a0f975aabb10d006e4da568744d06c61de6d95231cd89026e286df3b6ae4a894a3378e393e93a0f45b666329a0ae34")
            sig = hex2bytes("3045022000eff69ef2b1bd93a66ed5219add4fb51e11a840f404876325a1e8ffe0529a2c022100c7207fee197d27c618aea621406f6bf5ef6fca38681d82b2f06fddbdce6feab601")
            stack = [sig, sec]
            @test Bitcoin.op_checksig(stack, z) == true
            @test Bitcoin.decode_num(stack[1]) == 1
        end
        # TODO
        @testset "op_checksigverify" begin
        end
        # TODO
        @testset "op_checkmultisig" begin
        end
        # TODO
        @testset "op_checkmultisigverify" begin
        end
    end
    @testset "Nonoperators" begin
    end
    @testset "Reserved OP codes for internal use by the parser operators" begin
    end
end
