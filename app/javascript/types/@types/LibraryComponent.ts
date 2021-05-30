export type LoggedInUser = {
  id: number,
  username: string,
  profile: string,
  email: string,
  created_at: string,
  updated_at: string,
  admin: boolean
}

export interface PostsData {
  id: number,
  genre: string,
  image: string,
  ingredients: string,
  memo: string,
  title: string,
  created_at: string,
  updated_at: string,
  user_id: number
}