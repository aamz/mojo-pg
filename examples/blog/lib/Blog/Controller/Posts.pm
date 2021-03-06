package Blog::Controller::Posts;
use Mojo::Base 'Mojolicious::Controller';

sub show {
  my $self = shift;
  $self->stash(post => $self->posts->find($self->param('id')));
}

sub store {
  my $self = shift;

  my $validation = $self->validation;
  $validation->required('title');
  $validation->required('body');
  return $self->render('posts/create') if $validation->has_error;

  my $title = $validation->param('title');
  my $body  = $validation->param('body');
  my $id    = $self->posts->add($title, $body);
  $self->redirect_to('show_post', id => $id);
}

1;
