module Linux
  module Utmpx
    # See /usr/include/bits/utmpx.h

    class Exitstatus < BinData::Record
      endian :little
      int16 :e_termination
      int16 :e_exit
    end

    class Uttv < BinData::Record
      endian :little
      int32 :tv_sec
      int32 :tv_usec
    end

    class UtmpxParser < BinData::Record
      UT_LINESIZE = 32
      UT_NAMESIZE = 32
      UT_HOSTSIZE = 256
      UT_IDSIZE = 4

      endian :little

      int16 :ut_type
      int16 :pad_type # Align
      int32 :ut_pid
      string :ut_line, :length => UT_LINESIZE, :trim_padding => true
      string :ut_id, :length => UT_IDSIZE, :trim_padding => true
      string :ut_user, :length => UT_NAMESIZE, :trim_padding => true
      string :ut_host, :length => UT_HOSTSIZE, :trim_padding => true
      exitstatus :ut_exit
      int32 :ut_session
      uttv  :ut_tv
      array :ut_addr_v6, :initial_length => 4 do
        int32
      end
      string :reserved, :length => 20

      def time
        Time.at(ut_tv.tv_sec, ut_tv.tv_usec)
      end
    end

  end
end
