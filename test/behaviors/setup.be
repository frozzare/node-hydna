//
//        Copyright 2011 Hydna AB. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//
//    1. Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//
//    2. Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY HYDNA AB ``AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
//  EVENT SHALL HYDNA AB OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
//  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
//  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
//  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
//  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are
//  those of the authors and should not be interpreted as representing
//  official policies, either expressed or implied, of Hydna AB.
//


//
//   Behaviors for testing suite
//



namespace = "test"
  script = "redirect"
    path = "./redirect.js"
  end

  script = "pong"
    path = "./signal.js"
  end

  flag = "redirected"
    connection    
  end

end


directive = "connect"

  token = "redirect"
    redirect("http://localhost:7010/redirected")
  end

  token = "redirected"
    set("test:redirected")
  end

  token = "deny"
    deny("DENIED_HANDSHAKE")
  end

end


directive = "open"

  channel = 0x1
    run("test:redirect")
  end

  channel = 0x2
    allow("OK")
  end

  channel = 0x3
    deny("NOT_ALLOWED")
  end

  channel = 0x5
    when = state("test:redirected")
      allow("REDIRECTED")
    end
    deny("NOT_REDIRECTED")
  end

end

directive = "emit"
  channel = 0x00112233
    run("test:pong")
  end
end