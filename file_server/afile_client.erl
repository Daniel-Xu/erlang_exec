-module(afile_client).
-export([ls/1, get_file/2, put_file/3]).

%% client to hide the messaging protocol

ls(Server) ->
    Server ! {self(), list_dir},
    receive
        {Server, List} ->
            List
    end.

get_file(Server, File) ->
    Server ! {self(), {get_file, File}},
    receive
        {Server, Content} ->
            Content
    end.

put_file(Server, FileName, Content) ->
    Server ! {self(), {put_file, FileName, Content}},
    receive
        {Server, State} ->
            State
    end.
